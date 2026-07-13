import 'package:flutter/material.dart';
import 'theme.dart';

/// Modern SVG-style feature button.
/// Monochromatic line icon, hover state, spacious padding, zero emojis.
class ModernFeatureButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color brandColor;
  final VoidCallback? onTap;

  const ModernFeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.brandColor,
    this.onTap,
  });

  @override
  State<ModernFeatureButton> createState() => _ModernFeatureButtonState();
}

class _ModernFeatureButtonState extends State<ModernFeatureButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: _hovered
                ? widget.brandColor.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: _hovered
                ? Border.all(color: widget.brandColor.withOpacity(0.25), width: 1)
                : Border.all(color: const Color(0xFFE8E8E8), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: _hovered ? widget.brandColor : const Color(0xFF999999),
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? widget.brandColor : const Color(0xFFAAAAAA),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modern smaller partner button (56x56)
class ModernSmallButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color brandColor;
  final VoidCallback? onTap;

  const ModernSmallButton({
    super.key,
    required this.icon,
    required this.label,
    required this.brandColor,
    this.onTap,
  });

  @override
  State<ModernSmallButton> createState() => _ModernSmallButtonState();
}

class _ModernSmallButtonState extends State<ModernSmallButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _hovered
                ? widget.brandColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.brandColor.withOpacity(0.2)
                  : const Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: _hovered ? widget.brandColor : const Color(0xFFAAAAAA),
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? widget.brandColor : const Color(0xFFBBBBBB),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modern action row in settings/profile
class ModernActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final Color brandColor;
  final VoidCallback? onTap;

  const ModernActionRow({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    required this.brandColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: brandColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFAAAAAA),
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: const Color(0xFFCCCCCC),
            ),
          ],
        ),
      ),
    );
  }
}