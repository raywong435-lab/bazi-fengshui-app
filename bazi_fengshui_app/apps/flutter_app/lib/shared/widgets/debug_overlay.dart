import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/report_response.dart';
import '../providers/debug_providers.dart';

class DebugOverlay extends ConsumerWidget {
  final Widget child;
  const DebugOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!kDebugMode) return child; // Release 模式下直接返回子 Widget

    final metadata = ref.watch(latestReportMetadataProvider);

    return Stack(
      children: [
        child,
        if (metadata != null) _FloatingDebugPanelFromMetadata(metadata: metadata),
      ],
    );
  }
}

class _FloatingDebugPanelFromMetadata extends StatefulWidget {
  final ReportMetadata metadata;
  const _FloatingDebugPanelFromMetadata({required this.metadata});

  @override
  State<_FloatingDebugPanelFromMetadata> createState() => _FloatingDebugPanelFromMetadataState();
}

class _FloatingDebugPanelFromMetadataState extends State<_FloatingDebugPanelFromMetadata> {
  Offset offset = const Offset(16, 120);
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final md = widget.metadata;

    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Draggable(
        feedback: _buildPanel(md, collapsed, dragging: true),
        childWhenDragging: const SizedBox.shrink(),
        onDragEnd: (details) {
          setState(() {
            offset = details.offset;
          });
        },
        child: GestureDetector(
          onDoubleTap: () => setState(() => collapsed = !collapsed),
          child: _buildPanel(md, collapsed),
        ),
      ),
    );
  }

  Widget _buildPanel(ReportMetadata md, bool collapsed, {bool dragging = false}) {
    final bg = dragging ? Colors.black54 : Colors.black87;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: collapsed ? 44 : 260,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 6)],
        ),
        child: collapsed
            ? const Icon(Icons.bug_report, color: Colors.white)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('DEBUG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => setState(() => collapsed = true),
                        child: const Icon(Icons.minimize, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _infoRow('Source', md.source),
                  _infoRow('Prompt', md.promptVersion),
                  _infoRow('Deploy', md.deployTag),
                  _infoRow('Cached', md.cacheTimestamp?.toLocal().toString() ?? 'N/A'),
                ],
              ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text('$label: ', style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Expanded(child: Text(value ?? '', style: const TextStyle(color: Colors.white, fontSize: 12), overflow: TextOverflow.ellipsis)),
          ],
        ),
      );
}
