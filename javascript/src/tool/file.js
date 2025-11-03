const fs = require('fs');
const path = require('path');

module.exports = {
  get (filePath) {
    try {
      return fs.readFileSync(filePath, 'utf8');
    } catch (error) {
      console.error(`ファイルの読み込みエラー: ${filePath}`, error.message);
      process.exit(1);
    }
  },

  put (filePath, content) {
    try {
      // ディレクトリが存在しない場合は作成
      const dir = path.dirname(filePath);
      if (!fs.existsSync(dir)) {
          fs.mkdirSync(dir, { recursive: true });
      }

      fs.writeFileSync(filePath, content, 'utf8');
      console.log(`結果を保存しました: ${filePath}`);
    } catch (error) {
      console.error(`ファイルの書き込みエラー: ${filePath}`, error.message);
    }
  }
}
