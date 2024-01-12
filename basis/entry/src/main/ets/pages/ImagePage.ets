import { Header } from '../common/components/commonComponents'
@Entry
@Component
struct ImagePage {
    @State imageWidth: number = 150

    build() {
            Column() {
                Header({title:'图片案例'})
                Row(){
                    Image($r('app.media.icon'))
                        .width(this.imageWidth)
                        .interpolation(ImageInterpolation.High)
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .height(400)

                Row(){
                    Text($r('app.string.width_label'))
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)

                    TextInput({ placeholder: '请输入图片宽度', text: this.imageWidth.toFixed(0) })
                        .width(150)
                        .backgroundColor('#fff')
                        .type(InputType.Number)
                        .onChange(value => {
                            if (value) {
                                this.imageWidth = parseInt(value)
                            }
                        })
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding({left:50,right:50})

                Divider()
                    .width('100%')
                    .padding({left:'50',right:'50'})

                Row(){
                    Button('缩小')
                        .width(80)
                        .fontSize(20)
                        .onClick(() => {
                            if (this.imageWidth >= 10) {
                                this.imageWidth -= 10
                            }
                        })
                    Button('放大')
                        .width(80)
                        .fontSize(20)
                        .onClick(() => {
                            if (this.imageWidth < 300) {
                                this.imageWidth += 10
                            }
                        })
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceEvenly)
                .margin({top:'35',bottom:'35'})

                Slider({
                    min: 0,
                    max: 300,
                    value: this.imageWidth,
                    step: 10
                })
                    .width('90%')
                    .blockColor('#36D')
                    .trackThickness(6)
                    .showTips(true)
                    .onChange(value => {
                        this.imageWidth = value
                    })
            }
            .width('100%')
        }
}