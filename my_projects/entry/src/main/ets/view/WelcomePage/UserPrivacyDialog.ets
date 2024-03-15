import { CommonConstants } from '../../common/constants/CommonConstants'
@Preview
@CustomDialog
export default struct UserPrivacyDialog {
  controller: CustomDialogController
  confirm: ()=> void
  cancel: ()=> void

  build() {
    Column({space:10}){
      // 1.标题
      Text('欢迎使用健康监控')
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      // 2.内容
      Text($r('app.string.user_privacy_content'))
      // 3.按钮
      Button($r('app.string.agree_label'))
        .width(150)
        .backgroundColor($r('app.color.primary_color'))
        .onClick(()=>{
          this.confirm()
          this.controller.close()
        })
      Button($r('app.string.refuse_label'))
        .width(150)
        .backgroundColor($r('app.color.lightest_primary_color'))
        .fontColor($r('app.color.light_gray'))
        .onClick(()=>{
          this.cancel()
          this.controller.close()
        })
    }
    .width('100%')
    .padding(10)
  }
}