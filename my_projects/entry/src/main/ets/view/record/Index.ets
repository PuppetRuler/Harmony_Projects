import SearchComponent from './Search'
@Component
export default struct Record {
  build() {
    Column(){
      // 1. 头部搜索栏
      SearchComponent()
      // 2. 统计卡片

      // 3. 记录列表

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}