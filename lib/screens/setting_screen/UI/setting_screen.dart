import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/setting_screen/provider/locale_pvd.dart';
import 'package:weatherapp/styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localePvd = context.watch<LocalePvd>();
    return Scaffold(
      appBar: AppBar(
        title: Text(L.of(context)!.settings),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Clr.C363B64),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            L.of(context)!.set_language,
            style: TStyle.T_14_400_15(Clr.C363B64),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Clr.CD3D3D3,
            ),
            padding: const EdgeInsets.all(12),
            child: DefaultTextStyle(
              style: TStyle.T_16_400_15(Clr.C363B64),
              child: DropdownButton(
                style: TStyle.T_16_400_15(Clr.C363B64),
                underline: const SizedBox(),
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: LocalType.english,
                    child: Text(LocalType.english.displayName),
                  ),
                  DropdownMenuItem(
                    value: LocalType.marathi,
                    child: Text(LocalType.marathi.displayName),
                  ),
                ],
                hint: Text(localePvd.selectedLocale.displayName),
                onChanged: (value) {
                  if (value != null) {
                    localePvd.selectLocate(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
