import router from '@ohos.router'

@Component
export struct Header {
    // 标题
    private title: ResourceStr
    // id
    @State params: any = router.getParams()

    build() {
        Row() {
            Image($r('app.media.return'))
                .width(30)
                .onClick(() => {
                    // 返回前的警告
                    // router.showAlertBeforeBackPage({message:'当前还未支付，确定要返回吗?'})
                    // 返回路由
                    router.back()
                })
            if (this.params.id && this.title) {
                Text(this.params.id + '.' + this.title)
                    .fontSize(30)
                    .fontWeight(FontWeight.Bold)
            }
            Blank()
            Image($r('app.media.refresh'))
                .width(30)
        }
        .width('100%')
        .height(30)
    }
}