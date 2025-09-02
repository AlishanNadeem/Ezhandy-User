class CommonSuccessScreenRoutingArgument {
  String? buttonText;
  String? mainText;
  bool? isBack;
  void Function()? onclick;
  CommonSuccessScreenRoutingArgument(
      {required this.buttonText, required this.mainText,this.isBack ,this.onclick});
}
