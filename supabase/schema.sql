-- SamaKaya Database Schema
-- Run this in Supabase SQL Editor

-- 1. PROFILES TABLE
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT DEFAULT '',
  phone TEXT UNIQUE,
  avatar_url TEXT DEFAULT '',
  language TEXT DEFAULT 'en',
  token_balance INTEGER DEFAULT 0,
  streak INTEGER DEFAULT 0,
  is_founder BOOLEAN DEFAULT FALSE,
  genesis_badge_claimed BOOLEAN DEFAULT FALSE,
  referral_code TEXT UNIQUE,
  referred_by UUID REFERENCES profiles(id),
  referral_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- RLS: users can only read/update their own profile
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- 2. DAILY CLAIMS TABLE
CREATE TABLE IF NOT EXISTS daily_claims (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) NOT NULL,
  claimed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  claim_date DATE NOT NULL DEFAULT CURRENT_DATE,
  timezone_offset TEXT DEFAULT '',
  server_timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  geolocation_lat DECIMAL(10,7),
  geolocation_lng DECIMAL(10,7),
  CONSTRAINT unique_daily_claim UNIQUE (user_id, claim_date)
);

ALTER TABLE daily_claims ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own claims"
  ON daily_claims FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own claims"
  ON daily_claims FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 3. REFERRALS TABLE
CREATE TABLE IF NOT EXISTS referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referrer_id UUID REFERENCES profiles(id) NOT NULL,
  referred_id UUID REFERENCES profiles(id) NOT NULL,
  bonus_claimed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ
);

ALTER TABLE referrals ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own referrals"
  ON referrals FOR SELECT
  USING (auth.uid() = referrer_id);

-- 4. AGENCY REVIEWS TABLE
CREATE TABLE IF NOT EXISTS agency_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) NOT NULL,
  agency_name TEXT NOT NULL,
  agency_license TEXT,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  review_text TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  court_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE agency_reviews ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Agency reviews are public for reading"
  ON agency_reviews FOR SELECT
  USING (true);

CREATE POLICY "Users can insert own reviews"
  ON agency_reviews FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. RECEIPTS TABLE (for Price Shaming Engine)
CREATE TABLE IF NOT EXISTS receipts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  image_hash TEXT,
  merchant_name TEXT,
  amount DECIMAL(10,2),
  category TEXT,
  ocr_text TEXT,
  ocr_accuracy DECIMAL(5,2),
  verified_by_peers INTEGER DEFAULT 0,
  is_public BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert own receipts"
  ON receipts FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 6. UNDERPAYMENT LOGS TABLE
CREATE TABLE IF NOT EXISTS underpayment_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) NOT NULL,
  month_year TEXT NOT NULL,
  cash_received DECIMAL(10,2),
  statutory_minimum DECIMAL(10,2) DEFAULT 5100,
  deductions_amount DECIMAL(10,2) DEFAULT 0,
  flag_issue BOOLEAN DEFAULT FALSE,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE underpayment_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own logs"
  ON underpayment_logs FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own logs"
  ON underpayment_logs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 7. SPORTS LEAGUES TABLE
CREATE TABLE IF NOT EXISTS sports_leagues (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  sport_type TEXT NOT NULL,
  commissioner_id UUID REFERENCES profiles(id),
  max_teams INTEGER DEFAULT 8,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE sports_leagues ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leagues are publicly viewable"
  ON sports_leagues FOR SELECT
  USING (true);

-- 8. MAP PINS TABLE
CREATE TABLE IF NOT EXISTS map_pins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  latitude DECIMAL(10,7) NOT NULL,
  longitude DECIMAL(10,7) NOT NULL,
  description TEXT,
  is_approved BOOLEAN DEFAULT FALSE,
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE map_pins ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Approved pins are public"
  ON map_pins FOR SELECT
  USING (is_approved = true);

-- 9. FUNCTIONS

-- Daily claim function
CREATE OR REPLACE FUNCTION claim_daily(p_user_id UUID)
RETURNS void AS $$
DECLARE
  last_claim_date DATE;
  current_streak INTEGER;
BEGIN
  SELECT claim_date INTO last_claim_date
  FROM daily_claims
  WHERE user_id = p_user_id
  ORDER BY claim_date DESC
  LIMIT 1;

  -- Update streak
  IF last_claim_date = CURRENT_DATE - 1 THEN
    UPDATE profiles
    SET streak = streak + 1,
        token_balance = token_balance + 100
    WHERE id = p_user_id;
  ELSIF last_claim_date IS NULL OR last_claim_date < CURRENT_DATE - 1 THEN
    UPDATE profiles
    SET streak = 1,
        token_balance = token_balance + 100
    WHERE id = p_user_id;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Genesis drop function
CREATE OR REPLACE FUNCTION claim_genesis(p_user_id UUID)
RETURNS boolean AS $$
DECLARE
  founder_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO founder_count
  FROM profiles
  WHERE is_founder = TRUE;

  IF founder_count >= 10000 THEN
    RETURN FALSE;
  END IF;

  UPDATE profiles
  SET is_founder = TRUE,
      genesis_badge_claimed = TRUE,
      token_balance = token_balance + 10000
  WHERE id = p_user_id AND genesis_badge_claimed = FALSE;

  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Referral bonus function
CREATE OR REPLACE FUNCTION claim_referral_bonus(p_referrer_id UUID, p_referred_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE profiles
  SET token_balance = token_balance + 2000,
      referral_count = referral_count + 1
  WHERE id = p_referrer_id;

  UPDATE profiles
  SET token_balance = token_balance + 1000
  WHERE id = p_referred_id;

  UPDATE referrals
  SET bonus_claimed = TRUE,
      completed_at = NOW()
  WHERE referrer_id = p_referrer_id AND referred_id = p_referred_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Genesis counter view
CREATE OR REPLACE VIEW genesis_counter AS
SELECT
  10000 - COUNT(*) AS spots_remaining
FROM profiles
WHERE is_founder = TRUE;