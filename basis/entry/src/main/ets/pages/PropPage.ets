// 任务类
import { Header } from '../common/components/commonComponents'
@Observed
class Task {
    static id: number = 1
    // 任务名称
    name: string = `任务${Task.id++}`
    // 任务状态:是否完成
    finished: boolean = false
}

// 统一的卡片样式
@Styles function card() {
    .width('95%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(15)
    .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

// 任务完成样式
@Extend(Text) function finishedTask() {
    .decoration({ type: TextDecorationType.LineThrough })
    .fontColor('#B1B2B1')
}

class statTask {
    // 总任务数量
    totalTask: number = 0
    // 已完成任务数量
    finishTask: number = 0
}


@Entry
@Component
struct PropPage {
    @State stat:statTask = new statTask()

    build() {
        Column({ space: 10 }) {
            Header()
            // 1.任务进度卡片
            TaskStatistics({ finishTask: this.stat.finishTask, totalTask: this.stat.totalTask })
            // 2.新增任务按钮
            // 3.任务列表
            TaskList({ stat:$stat })
                .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F1F2F3')
    }
}

@Component
struct TaskStatistics {
    @Prop finishTask: number
    @Prop totalTask: number

    build() {
        Row() {
            Text('任务进度:')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
            Stack() {
                Progress({
                    value: this.finishTask,
                    total: this.totalTask,
                    type: ProgressType.Ring
                })
                    .width(100)
                Row() {
                    Text(this.finishTask.toString())
                        .fontSize(24)
                        .fontColor('#36D')
                    Text('/' + this.totalTask.toString())
                        .fontSize(24)
                }
            }
        }
        .card()
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 20 })
    }
}

@Component
struct TaskList {
    // 总任务数量
    @Link stat:statTask
    // 任务数组
    @State tasks: Task[] = []

    build() {
        Column({space:10}) {
            Button('新增任务')
                .width(200)
                .onClick(() => {
                    // 1.新增任务数据
                    this.tasks.push(new Task())
                    // 2. 更新任务总数量
                    this.stat.totalTask = this.tasks.length
                })
            List({ space: 10 }) {
                ForEach(this.tasks, (item: Task, index) => {
                    ListItem() {
                        TaskItem({item:item,onChangeItem:this.TaskChangeHandler.bind(this)})
                    }
                    .swipeAction({ end: this.DeleteButton(index) })
                })
            }
            .width('100%')
            .layoutWeight(1)
            .alignListItem(ListItemAlign.Center)
        }
    }

    TaskChangeHandler(){
        // 更新已完成任务数量
        this.stat.finishTask = this.tasks.filter(item => item.finished).length
    }

    @Builder DeleteButton(index: number) {
        Button() {
            Image($r('app.media.delete'))
                .fillColor(Color.White)
                .width(20)
        }
        .width(40)
        .height(40)
        .type(ButtonType.Circle)
        .backgroundColor(Color.Red)
        .margin(5)
        .onClick(() => {
            this.tasks.splice(index, 1)
            this.stat.totalTask = this.tasks.length
            this.stat.finishTask = this.tasks.filter(item => item.finished).length
        })
    }
}

@Component
struct TaskItem{
    @ObjectLink item:Task
    onChangeItem:()=>void

    build(){
        Row() {
            if(this.item.finished){
                Text(this.item.name)
                    .fontSize(20)
                    .finishedTask()
            }else{
                Text(this.item.name)
                    .fontSize(20)
            }
            Checkbox()
                .select(this.item.finished)
                .onChange(val => {
                    // 更新当前任务状态
                    this.item.finished = val
                    // 更新已完成任务数量
                    this.onChangeItem()
                })
        }
        .card()
        .justifyContent(FlexAlign.SpaceBetween)
    }
}