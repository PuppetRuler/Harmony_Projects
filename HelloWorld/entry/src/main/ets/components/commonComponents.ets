@Component
export  struct  Header {
    // 标题
    private title: ResourceStr
    build() {
        Row() {
            Image($r('app.media.return'))
                .width(30)
            Text(this.title)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
            Blank()
            Image($r('app.media.refresh'))
                .width(30)
        }
        .width('100%')
        .height(30)
    }
}