import argparse
import os
from pathlib import Path

def get_package_name():
    try:
        with open('pubspec.yaml', 'r') as f:
            for line in f:
                if line.strip().startswith('name:'):
                    name_line = line.split(':')[1].strip()
                    name = name_line.replace("'", "").replace('"', '')
                    return name
        return None
    except FileNotFoundError:
        return None

def main():
    parser = argparse.ArgumentParser(description='Generate Flutter flow structure.')
    parser.add_argument('flow_name', help='Name of the flow (snake_case)')
    args = parser.parse_args()
    flow_name = args.flow_name

    package_name = get_package_name()
    if not package_name:
        print("Error: Could not read package name from pubspec.yaml")
        return

    pascal = ''.join([word.capitalize() for word in flow_name.split('_')])
    pascal_plural = pascal
    snake = flow_name

    base_dir = Path('lib') / 'pages' / flow_name

    files = [
        {
            'path': base_dir / 'bindings' / f'{snake}_binding.dart',
            'template': '''import 'package:get/get.dart';
import 'package:{package_name}/pages/{flow_name}/data/{snake}_api_provider.dart';
import 'package:{package_name}/pages/{flow_name}/data/{snake}_repository.dart';
import 'package:{package_name}/pages/{flow_name}/presentation/controller/{snake}_controller.dart';

class {pascal_plural}Binding extends Bindings {{
  @override
  void dependencies() {{
    Get.put<I{pascal_plural}Provider>({pascal_plural}Provider());
    Get.put<I{pascal_plural}Repository>({pascal_plural}Repository(provider: Get.find()));
    Get.put({pascal_plural}Controller({snake}Repository: Get.find()));
  }}
}}
'''
        },
        {
            'path': base_dir / 'data' / f'{snake}_api_provider.dart',
            'template': '''import 'package:{package_name}/base/base_auth_provider.dart';

abstract class I{pascal_plural}Provider {{

}}

class {pascal_plural}Provider extends BaseAuthProvider implements I{pascal_plural}Provider {{

}}
'''
        },
        {
            'path': base_dir / 'data' / f'{snake}_repository.dart',
            'template': '''import 'package:{package_name}/base/base_repository.dart';
import 'package:{package_name}/pages/{flow_name}/data/{snake}_api_provider.dart';

abstract class I{pascal_plural}Repository {{

}}

class {pascal_plural}Repository extends BaseRepository implements I{pascal_plural}Repository {{
  {pascal_plural}Repository({{required this.provider}});

  final I{pascal_plural}Provider provider;
}}
'''
        },
        {
            'path': base_dir / 'model' / 'model.dart',
            'template': '''// Model classes for {pascal_plural} flow
'''
        },
        {
            'path': base_dir / 'presentation' / 'controller' / f'{snake}_controller.dart',
            'template': '''import 'package:get/get.dart';
import 'package:{package_name}/pages/{flow_name}/data/{snake}_repository.dart';
import 'package:{package_name}/pages/{flow_name}/model/model.dart';
import 'package:{package_name}/resources/strings_generated.dart';
import 'package:{package_name}/services/auth_service.dart';

class {pascal_plural}Controller extends SuperController<bool> {{
  {pascal_plural}Controller({{required this.{snake}Repository}});

  final I{pascal_plural}Repository {snake}Repository;
 
  @override
  void onDetached() {{
    // TODO: implement onDetached
  }}

  @override
  void onHidden() {{
    // TODO: implement onHidden
  }}

  @override
  void onInactive() {{
    // TODO: implement onInactive
  }}

  @override
  void onPaused() {{
    // TODO: implement onPaused
  }}

  @override
  void onResumed() {{
    // TODO: implement onResumed
  }}
}}
'''
        },
        {
            'path': base_dir / 'presentation' / 'view' / 'widgets' / f'{snake}_screen.dart',
            'template': '''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{package_name}/pages/{flow_name}/presentation/controller/{snake}_controller.dart';

class {pascal_plural}Screen extends GetView<{pascal_plural}Controller> {{
  const {pascal_plural}Screen({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: const Text('{pascal_plural}'),
      ),
      body: const Center(
        child: Text('{pascal_plural} Screen'),
      ),
    );
  }}
}}
'''
        },
    ]

    for file_info in files:
        path = file_info['path']
        template = file_info['template']
        content = template.format(
            package_name=package_name,
            flow_name=flow_name,
            snake=snake,
            pascal_plural=pascal_plural,
        )
        os.makedirs(path.parent, exist_ok=True)
        with open(path, 'w') as f:
            f.write(content)
        print(f'Created: {path}')

if __name__ == '__main__':
    main()