String textResizer(String text, [int maxLength = 8]) {
  if (text.length > maxLength) {
    return text.replaceRange(maxLength, null, '..');
  } else {
    return text;
  }
}
