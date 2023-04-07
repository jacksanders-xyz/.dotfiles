import { run, css, React } from "uebersicht"

const orgWorkFilePath = "/Users/jsanders/orgfiles/work.org"
const orgTimeCardPath = "/Users/jsanders/orgfiles/recurring.org"

const header = css`
  font-family: IosevkaTerm Nerd Font;
  font-size: 20px;
  font-style: bold;
  color: white;
`

const boxes = css`
`

const box = css({
    height: "40px",
    width: "40px",
    "& + &": {
        marginLeft: "5px"
    }
})

export const className = `
    top: 0px;
`

const background = css({
    background: "rgba(52, 52, 52, 0.8)",
    width: "140%",
    height: "1000px"
})


const taskStyle = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: l8px;
    color: white;
`

const taskStyleTodo = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: l8px;
    color: green;
`

const taskBox = css`
    font-family: IosevkaTerm Nerd Font;
    word-break: break-all;
`

    // sed '/CLOSED/d;/DONE/d;/:.*:/d;/SCHEDULED/d' ${orgTimeCardPath}
export const command = `
    sed '/CLOSED/d;/DONE/d' ${orgWorkFilePath}
    sed '' ${orgTimeCardPath}
`
// grep -E '\\* TODO |DEADLINE' ${orgFilePath}
// jq -s -R 'split("\n") | .[:-1]' ${orgFilePath}

export const render = (props) => {
    console.log(props.output)

    // let taskArray = [];
    // let cutString = props.output.split('>\n')
    // cutString.forEach((task) => {
    //     if (task) {
    //         let taskChunk = task.split("\n")
    //         let taskBody = taskChunk[0].split("* TODO ")
    //         taskArray.push({ taskType:"todo", taskVal: taskBody[1], taskDeadline: taskChunk[1] })
    //     }
    // })

    // const listItems = taskArray.map((task, idx) => (
    //     <ul className={taskStyleTodo}>* TODO
    //         <ul className={taskStyle}>{task.taskVal}</ul>
    //         <ul className={taskStyle}>{task.taskDeadline}</ul>
    //     </ul>
    // ));

    return (
        <div className={background}>
            <h1 className={header}>Tasks</h1>
            <div className={taskBox}>
            </div>
        </div>
    )
}

