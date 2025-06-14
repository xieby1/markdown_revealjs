// Make cjk characters double widh (2ch) as latin characters
//
// Common mono fonts like "noto mono cjk" not support,
// sarasa mono looks inharmonious.
// Only css cannot solve this problem: I have tried "letter-spacing", "text-transform", "font-face"
// Related problems:
// * https://stackoverflow.com/questions/10149330/force-non-monospace-font-into-fixed-width-using-css
// * https://stackoverflow.com/questions/49344561/how-to-make-double-width-chars-exactly-twice-of-single-width-chars
// * https://github.com/JetBrains/JetBrainsMono/issues/20
// So I decide to utilize javascript
// by asking deepseek:
// * 能不能写一个javascript代码，吧pre code里的每个字都放入一个等宽的span里？
// * 我可不可以只把cjk字符装进span，设置宽度为2ch，其他字符都不用管？这样可行吗？
// So I get the following perfect solution!
function cjk2ch(selector) {
  const elements = document.querySelectorAll(selector);
  elements.forEach(element => {
    // 获取原始文本
    const text = element.textContent;
    // 清空元素内容
    element.innerHTML = '';
    // append_buffer可以避免html里一个字一行，不好看
    append_buffer = "";
    function flush_buffer() {
      if (append_buffer != "") {
        element.append(append_buffer);
        append_buffer = "";
      }
    }

    function span(char, width) {
      flush_buffer()
      const span = document.createElement('span');
      span.textContent = char;
      span.style.display = 'inline-block';
      span.style.width = width;
      span.style.textAlign = 'center';
      element.appendChild(span);
    }
    // 遍历每个字符
    for (const char of text) {
      // 完整 CJK 字符范围（汉字+标点+日文假名+韩文）
      const cjkRegex = /[\u3000-\u303f\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\uac00-\ud7af]/;
      // 一些符号（比如画线框的符号）在某些cjk mono字体里（比如noto）被设计成了全宽度
      const symRegex = /[\u2500-\u257f]/
      if (cjkRegex.test(char)) {
        span(char, "2ch")
      } else if (symRegex.test(char)) {
        span(char, "1ch")
      } else {
        // 非 CJK 字符直接插入append_buffer
        append_buffer += char;
      }
    }
    flush_buffer()
  });
};
