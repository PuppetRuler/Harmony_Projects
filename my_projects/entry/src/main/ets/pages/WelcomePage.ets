import common from '@ohos.app.ability.common'
import router from '@ohos.router'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import UserPrivacyDialog from '../view/WelcomePage/UserPrivacyDialog'

@Extend(Text) function opacityWhiteTextStyle(fs: number = 10, op: number) {
  .fontSize(fs).opacity(op).fontColor(Color.White)
}

const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.onCancel()
    })
  })

  aboutToAppear() {
    // 1. 加载首选项
    let isAgree = PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    // 2. 判断首选项
    if (isAgree) {
      // 2.1 同意，加载主页
      this.jumpToIndex()
    } else {
      // 2.2 不同意，弹窗
      this.controller.open()
    }
  }

  jumpToIndex(){
    setTimeout(()=>{
      router.replaceUrl({
        url:'pages/Index'
      })
    },1000)
  }

  // 同意协议
  onConfirm() {
    // 保存到首选项
    PreferenceUtil.putPreferenceValue(PREF_KEY,true)
    //进入首页
    this.jumpToIndex()
  }
  // 关闭App
  onCancel() {
    // 退出App
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {
      // 1. 中央slogin
      Row() {
        Image($r('app.media.home_slogan')).width(260)
      }.layoutWeight(1)
      // 2. logo
      Image($r('app.media.home_logo')).width(150)
      // 3. 文字描述
      Row() {
        Text('黑马健康支持').opacityWhiteTextStyle(12, 0.8)
        Text('IPv6')
          .opacityWhiteTextStyle(12, 0.8)
          .border({ style: BorderStyle.Solid, width: 1, color: Color.White, radius: 15 })
          .padding({ left: 5, right: 5 })
        Text('网络').opacityWhiteTextStyle(12, 0.8)
      }

      Text("'减更多'指黑马健康App希望通过软件工具的形式，帮助更多用户实现身材管理")
        .opacityWhiteTextStyle(10, 0.6)
      Text('浙ICP备0000000号-36D')
        .opacityWhiteTextStyle(8, 0.4).margin({ bottom: 35 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.welcome_page_background'))
  }
}