import 'package:flutter/material.dart';

import '../../core/utils/avatars.dart';

void showPickAvatarSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return const PickAvatarSheet();
    },
  );
}

class PickAvatarSheet extends StatefulWidget {
  const PickAvatarSheet({super.key});

  @override
  State<PickAvatarSheet> createState() => _PickAvatarSheetState();
}

class _PickAvatarSheetState extends State<PickAvatarSheet> {
  String? _selectedKey;

  void _onImageTap(String key) {
    setState(() {
      if (_selectedKey == key) {
        _selectedKey = null;
      } else {
        _selectedKey = key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child:  Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _header(
              onClose: () => Navigator.pop(context),
            ),
            const TextField(
              decoration: InputDecoration(
                prefixText: '@',
                prefixStyle: TextStyle(color: Colors.grey, fontSize: 16),
                hintText: 'Enter your nickname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final key = avatars.keys.elementAt(index);
                  final avatar = avatars[key]!;
                  final isSelected = _selectedKey == key;

                  return InkWell(
                    onTap: () => _onImageTap(key),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.indigo : Colors.transparent,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: avatar.image,
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header({ required VoidCallback onClose }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Personalize Your Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
      ],
    );
  }
}