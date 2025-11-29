"""
Sign言語構文解析器のテスト

ポイントフリー記法を含む包括的なテストスイート
"""

import sys
from pathlib import Path

# 親ディレクトリをパスに追加
sys.path.insert(0, str(Path(__file__).parent))

from lexer import Lexer, TokenType
from parser import Parser
from ast_nodes import *


def test_case(name: str, code: str, description: str = ""):
    """テストケースを実行"""
    print(f"\n{'='*60}")
    print(f"テスト: {name}")
    if description:
        print(f"説明: {description}")
    print(f"コード: {code}")
    print(f"{'='*60}")
    
    try:
        lexer = Lexer(code)
        tokens = lexer.tokenize()
        
        parser = Parser(tokens)
        ast = parser.parse()
        
        print("✓ 成功")
        print(f"\nAST:\n{ast.to_dict()}")
        return True
    except Exception as e:
        print(f"✗ エラー: {e}")
        return False


def main():
    """テストスイート実行"""
    print("="*60)
    print("Sign言語構文解析器 テストスイート")
    print("="*60)
    
    tests_passed = 0
    tests_total = 0
    
    # ========== 基本リテラル ==========
    print("\n\n" + "="*60)
    print("基本リテラルのテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("整数リテラル", "42"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("浮動小数リテラル", "3.14"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("16進数リテラル", "0xFF"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("文字列リテラル", "`hello world`"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("文字リテラル", "\\x"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("Unit", "_"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("識別子", "myVariable"):
        tests_passed += 1
    
    # ========== 代入式 ==========
    print("\n\n" + "="*60)
    print("代入式のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("基本的な代入", "x : 5"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("文字列の代入", "name : `Alice`"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("式の代入", "result : 1 + 2"):
        tests_passed += 1
    
    # ========== ラムダ式 ==========
    print("\n\n" + "="*60)
    print("ラムダ式のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("1引数ラムダ", "x ? x"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("2引数ラムダ", "x y ? x + y"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("ラムダ定義", 
                 "add : x y ? x + y",
                 "関数定義（代入 + ラムダ）"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("連続パラメータラムダ", 
                 "tail : x ~y ? y",
                 "連続パラメータ ~y を使用"):
        tests_passed += 1
    
    # ========== リスト（積） ==========
    print("\n\n" + "="*60)
    print("リスト（積）のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("積による リスト", "1, 2, 3"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("ブロック内のリスト", "[1, 2, 3]"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("文字列リスト", "`a`, `b`, `c`"):
        tests_passed += 1
    
    # ========== 算術演算 ==========
    print("\n\n" + "="*60)
    print("算術演算のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("加算", "1 + 2"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("減算", "5 - 3"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("乗算", "3 * 4"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("除算", "10 / 2"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("複合演算", "1 + 2 * 3",
                 "優先順位: 1 + (2 * 3) = 7"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("括弧による優先順位変更", "(1 + 2) * 3",
                 "優先順位: (1 + 2) * 3 = 9"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("冪乗", "2 ^ 3",
                 "2の3乗 = 8"):
        tests_passed += 1
    
    # ========== 論理演算 ==========
    print("\n\n" + "="*60)
    print("論理演算のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("論理積", "x & y"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("論理和", "x | y"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("排他的論理和", "x ; y"):
        tests_passed += 1
    
    # ========== 比較演算 ==========
    print("\n\n" + "="*60)
    print("比較演算のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("等価比較", "x = 5"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("大小比較", "x < 10"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("連鎖比較", "1 < x < 10",
                 "連鎖比較: 1 < x AND x < 10"):
        tests_passed += 1
    
    # ========== ポイントフリー記法 ==========
    print("\n\n" + "="*60)
    print("ポイントフリー記法のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("DirectFold (加算)", "[+]",
                 "演算子のみ → リストの畳み込み"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("DirectFold (乗算)", "[*]",
                 "演算子のみ → リストの畳み込み"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("右部分適用", "[+ 1]",
                 "演算子 + 値 → 右側を1に固定"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("左部分適用", "[5 -]",
                 "値 + 演算子 → 左側を5に固定"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("map用（カンマ付き）", "[* 2,]",
                 "カンマ付き → map演算として使用"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("前置演算子のポイントフリー化", "[!]",
                 "NOT演算子をポイントフリー化"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("アドレス演算子のポイントフリー化", "[$]",
                 "アドレス取得演算子をポイントフリー化"):
        tests_passed += 1
    
    # ========== 複合テスト ==========
    print("\n\n" + "="*60)
    print("複合構文のテスト")
    print("="*60)
    
    tests_total += 1
    if test_case("関数適用", "[+ 1] 5",
                 "ポイントフリー関数を値に適用"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("複数代入式", """x : 5
y : 10""",
                 "複数の文を改行で区切る"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("ネストしたブロック", "[(1 + 2)]",
                 "ブロック内にさらにブロック"):
        tests_passed += 1
    
    # ========== 実践的な例 ==========
    print("\n\n" + "="*60)
    print("実践的な例")
    print("="*60)
    
    tests_total += 1
    if test_case("階乗関数（概念）", "factorial : n ? n",
                 "実際の階乗ロジックは省略"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("フィボナッチ（概念）", "fib : n ? n",
                 "実際のフィボナッチロジックは省略"):
        tests_passed += 1
    
    tests_total += 1
    if test_case("リスト操作", "[1, 2, 3]",
                 "リストリテラル"):
        tests_passed += 1
    
    # ========== 結果サマリー ==========
    print("\n\n" + "="*60)
    print("テスト結果サマリー")
    print("="*60)
    print(f"合計: {tests_total} テスト")
    print(f"成功: {tests_passed} テスト")
    print(f"失敗: {tests_total - tests_passed} テスト")
    print(f"成功率: {tests_passed / tests_total * 100:.1f}%")
    print("="*60)
    
    if tests_passed == tests_total:
        print("\n🎉 全てのテストが成功しました！")
    else:
        print(f"\n⚠️  {tests_total - tests_passed} 個のテストが失敗しました")
    
    return tests_passed == tests_total


if __name__ == '__main__':
    success = main()
    sys.exit(0 if success else 1)
