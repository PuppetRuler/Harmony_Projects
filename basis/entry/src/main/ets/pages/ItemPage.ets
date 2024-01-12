class Item {
    name: string
    image: string
    price: number
    discount?: number

    constructor(name, image, price, discount?) {
        this.name = name
        this.image = image
        this.price = price
        this.discount = discount
    }
}

// 全局自定义构建函数
// @Builder function ItemCard(item:Item) {
//     Row({ space: 10 }) {
//         Image(item.image)
//             .width(100)
//         Column({ space: 4 }) {
//             if (item.discount) {
//                 Text(item.name)
//                     .width('100%')
//                     .fontSize(20)
//                     .fontWeight(FontWeight.Bold)
//                 Text('原价:￥' + item.price)
//                     .width('100%')
//                     .fontColor('#ccc')
//                     .fontSize(14)
//                     .decoration({ type: TextDecorationType.LineThrough })
//                 Text('折扣价:￥' + item.discount)
//                     .width('100%')
//                     .fontColor('#f36')
//                     .fontSize(18)
//                 Text('补贴价:￥' + (item.price - item.discount))
//                     .width('100%')
//                     .fontColor('#f36')
//                     .fontSize(18)
//             } else {
//                 Text(item.name)
//                     .width('100%')
//                     .fontSize(20)
//                     .fontWeight(FontWeight.Bold)
//                 Text('￥' + item.price)
//                     .width('100%')
//                     .fontColor('#f36')
//                     .fontSize(18)
//             }
//         }
//         .height('100%')
//     }
//     .width('100%')
//     .backgroundColor('#fff')
//     .borderRadius(20)
//     .height(120)
//     .padding(10)
// }

// 全局公开样式函数
// @Styles function fillScreen() {
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#EFEFEF')
//     .padding(20)
// }

// 继承模式，只能写在全局
@Extend(Text) function textPrice(){
    .width('100%')
    .fontColor('#f36')
    .fontSize(18)
}

import { Header } from '../common/components/commonComponents'

@Entry
@Component
struct ItemList {
    // 商品数据
    private items: Array<Item> = [
        new Item('华为Mate60', $r('app.media.mate60'), 6999, 5999),
        new Item('MateBookProX', $r('app.media.mateBookProX'), 13999),
        new Item('WatchGT4', $r('app.media.freeBudsPro3'), 1438),
        new Item('华为Mate60', $r('app.media.mate60'), 6999, 5999),
        new Item('MateBookProX', $r('app.media.mateBookProX'), 13999),
        new Item('WatchGT4', $r('app.media.freeBudsPro3'), 1438),
        new Item('华为Mate60', $r('app.media.mate60'), 6999, 5999),
        new Item('MateBookProX', $r('app.media.mateBookProX'), 13999),
        new Item('WatchGT4', $r('app.media.freeBudsPro3'), 1438)
    ]

    // 局部自定义构建函数
    @Builder ItemCard(item:Item) {
    Row({ space: 10 }) {
        Image(item.image)
            .width(100)
        Column({ space: 4 }) {
            if (item.discount) {
                Text(item.name)
                    .width('100%')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                Text('原价:￥' + item.price)
                    .width('100%')
                    .fontColor('#ccc')
                    .fontSize(14)
                    .decoration({ type: TextDecorationType.LineThrough })
                Text('折扣价:￥' + item.discount)
                    .textPrice()
                Text('补贴价:￥' + (item.price - item.discount))
                    .textPrice()
            } else {
                Text(item.name)
                    .width('100%')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                Text('￥' + item.price)
                    .textPrice()
            }
        }
        .height('100%')
    }
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(20)
    .height(120)
    .padding(10)
}

    // 局部公开样式函数
    @Styles fillScreen() {
    .width('100%')
    .height('100%')
    .backgroundColor('#EFEFEF')
    .padding(20)
}

    build() {
        Column({ space: 8 }) {
            Header({ title: '商品列表' })
                .margin({ bottom: 20 })
            List({ space: 8 }) {
                ForEach(this.items, (item: Item) => {
                    ListItem() {
                        this.ItemCard(item)
                    }
                })
            }
            .width('100%')
            .layoutWeight(1)
        }
        .fillScreen()
    }
}