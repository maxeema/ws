
///

bool isEmpty(String s)    => s?.trim()?.isEmpty    ?? true;
bool isNotEmpty(String s) => s?.trim()?.isNotEmpty ?? false;

ms(int value) => Duration(milliseconds: value);
sec(int value) => Duration(seconds: value);
