"""
Sign言語構文解析器の簡易テスト

主要な機能を素早くテストするための簡易版テストスイート
"""

from lexer import Lexer
from parser import Parser
import json


def test(name, code):
    """テストケースを実行"""
    print(f"\n{'='*50}")
    print(f"テスト: {name}")
    print(f"コード: {code}")
    print('='*50)
    
    try:
        lexer = Lexer(code)
        tokens = lexer.tokenize()
        parser = Parser(tokens)
        ast = parser.parse()
        
        print("✓ 成功")
        print(json.dumps(ast.to_dict(), indent=2, ensure_ascii=False))
        return True
    except Exception as e:
        print(f"✗ エラー: {e}")
        import traceback
        traceback.print_exc()
        return False


def main():
    print("="*50)
    print("Sign言語構文解析器 簡易テストスイート")
    print("="*50)
    
    passed = 0
    total = 0
    
    # 基本リテラル
    print("\n■ 基本リテラル")
    tests = [
        ("整数", "42"),
        ("浮動小数", "3.14"),
        ("文字列", "`hello`"),
        ("識別子", "myVar"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # 代入
    print("\n■ 代入式")
    tests = [
        ("基本代入", "x : 5"),
        ("式の代入", "result : 1 + 2"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # ラムダ
    print("\n■ ラムダ式")
    tests = [
        ("1引数ラムダ", "x ? x"),
        ("2引数ラムダ", "x y ? x + y"),
        ("関数定義", "add : x y ? x + y"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # リスト
    print("\n■ リスト")
    tests = [
        ("積リスト", "1, 2, 3"),
        ("ブロックリスト", "[1, 2, 3]"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # 算術演算
    print("\n■ 算術演算")
    tests = [
        ("加算", "1 + 2"),
        ("複合演算", "1 + 2 * 3"),
        ("括弧", "(1 + 2) * 3"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # ポイントフリー記法
    print("\n■ ポイントフリー記法")
    tests = [
        ("DirectFold", "[+]"),
        ("右部分適用", "[+ 1]"),
        ("左部分適用", "[5 -]"),
        ("map用", "[* 2,]"),
    ]
    for name, code in tests:
        total += 1
        if test(name, code):
            passed += 1
    
    # サマリー
    print("\n" + "="*50)
    print(f"結果: {passed}/{total} テスト成功")
    print(f"成功率: {passed/total*100:.1f}%")
    print("="*50)
    
    if passed == total:
        print("\n🎉 全テスト成功！")
    else:
        print(f"\n⚠️  {total - passed} 個失敗")


if __name__ == '__main__':
    main()
