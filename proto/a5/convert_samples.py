"""
Sign言語サンプルファイルの一括変換スクリプト

test_samples/ 内の.snファイルをすべて構文解析し、
対応する.jsonファイルとして結果を保存します。
"""

import os
import json
from pathlib import Path
from lexer import Lexer
from parser import Parser


def convert_file(input_path: str, output_path: str) -> bool:
    """Signファイルを構文解析してJSON形式で保存"""
    try:
        # 入力ファイルを読み込み
        with open(input_path, 'r', encoding='utf-8') as f:
            source = f.read()
        
        print(f"\n{'='*60}")
        print(f"変換: {Path(input_path).name}")
        print(f"{'='*60}")
        print(f"入力ファイル: {input_path}")
        print(f"出力ファイル: {output_path}")
        
        # 構文解析
        lexer = Lexer(source)
        tokens = lexer.tokenize()
        
        parser = Parser(tokens)
        ast = parser.parse()
        
        # JSON形式で保存
        ast_dict = ast.to_dict()
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(ast_dict, f, indent=2, ensure_ascii=False)
        
        print(f"✓ 成功")
        print(f"ステートメント数: {len(ast.statements)}")
        
        return True
        
    except Exception as e:
        print(f"✗ エラー: {e}")
        import traceback
        traceback.print_exc()
        return False


def main():
    """メイン処理"""
    print("="*60)
    print("Sign言語サンプルファイル一括変換")
    print("="*60)
    
    # test_samples ディレクトリのパス
    samples_dir = Path(__file__).parent / "test_samples"
    
    if not samples_dir.exists():
        print(f"エラー: {samples_dir} が見つかりません")
        return
    
    # .snファイルを検索
    sn_files = sorted(samples_dir.glob("*.sn"))
    
    if not sn_files:
        print(f"エラー: {samples_dir} に .sn ファイルが見つかりません")
        return
    
    print(f"\n見つかったファイル: {len(sn_files)}個")
    
    # 各ファイルを変換
    success_count = 0
    for sn_file in sn_files:
        json_file = sn_file.with_suffix('.json')
        
        if convert_file(str(sn_file), str(json_file)):
            success_count += 1
    
    # サマリー
    print("\n" + "="*60)
    print("変換結果サマリー")
    print("="*60)
    print(f"合計ファイル数: {len(sn_files)}")
    print(f"成功: {success_count}")
    print(f"失敗: {len(sn_files) - success_count}")
    print("="*60)
    
    if success_count == len(sn_files):
        print("\n🎉 すべてのファイルの変換に成功しました！")
    else:
        print(f"\n⚠️  {len(sn_files) - success_count} 個のファイルの変換に失敗しました")
    
    # 変換されたファイルのリスト表示
    if success_count > 0:
        print("\n変換されたファイル:")
        for sn_file in sn_files:
            json_file = sn_file.with_suffix('.json')
            if json_file.exists():
                print(f"  - {sn_file.name} → {json_file.name}")


if __name__ == '__main__':
    main()
