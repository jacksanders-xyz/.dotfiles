import { run, css, React } from "uebersicht"

const orgWorkFilePath = "/Users/jsanders/orgfiles/work.org"
const orgTimeCardPath = "/Users/jsanders/orgfiles/recurring.org"

const py_env_path = "/Users/jsanders/orgfiles/py_text/pyenv.py"
const py_text_path = "/Users/jsanders/orgfiles/py_text/pytext.py"

const header = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: 20px;
    font-style: bold;
    color: white;
    flex: 1;
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
`

const background = css({
    background: "rgba(52, 52, 52, 0.8)",
    width: "140%",
    height: "100%",
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
    flex: 1;
`

const taskStyleTodo_thurs = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: l8px;
    color: green;
    flex: 1;
`

const taskStyleTodo_urg_fri = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: l8px;
    color: blue;
    flex: 1;
`

const taskStyleTodo_urg_sat_sun = css`
    font-family: IosevkaTerm Nerd Font;
    font-size: l8px;
    color: red;
    flex: 1;
`

const taskBox = css`
    font-family: IosevkaTerm Nerd Font;
    word-break: break-all;
    flex: 1;
`
const weekGrab = Date.prototype.getWeek = function (dowOffset=1) {
    dowOffset = typeof(dowOffset) == 'number' ? dowOffset : 0; //default dowOffset to zero
    var newYear = new Date(this.getFullYear(),0,1);
    var day = newYear.getDay() - dowOffset; //the day of week the year begins on
    day = (day >= 0 ? day : day + 7);
    var daynum = Math.floor((this.getTime() - newYear.getTime() -
    (this.getTimezoneOffset()-newYear.getTimezoneOffset())*60000)/86400000) + 1;
    var weeknum;
    //if the year starts before the middle of a week
    if(day < 4) {
        weeknum = Math.floor((daynum+day-1)/7) + 1;
        if(weeknum > 52) {
            nYear = new Date(this.getFullYear() + 1,0,1);
            nday = nYear.getDay() - dowOffset;
            nday = nday >= 0 ? nday : nday + 7;
            /*if the next year starts before the middle of
              the week, it is week #1 of that year*/
            weeknum = nday < 4 ? 1 : 53;
        }
    }
    else {
        weeknum = Math.floor((daynum+day-1)/7);
    }
    return weeknum;
};

    // sed '/CLOSED/d;/DONE/d;/:.*:/d;/SCHEDULED/d' ${orgTimeCardPath}

export const command = `
    sed '/CLOSED/d;/DONE/d' ${orgWorkFilePath}
    echo '\n_re-occurring_\n'
    sed -n '/:.*:/d;1,6p' ${orgTimeCardPath}
`
export const render = (props) => {
    props.output = props.output.split('\n_re-occurring_\n')
    let WorkToDos = props.output[0]
    let TimeCardToDos = props.output[1]

    let taskArrayWork = [];
    let taskArrayTime = [];

    let cutStringWork = WorkToDos.split('\>')
    let cutStringTimeCard = TimeCardToDos.split('\n')

    cutStringWork.forEach((task) => {
        if (task) {
            let taskChunk = task.split("\n").filter((t) => t!="")
            if (taskChunk[0]) {
                let taskBody = taskChunk[0].split("* TODO ")
                if (taskBody[1]) {
                    taskArrayWork.push({ taskType:"todo", taskVal: taskBody[1], taskDeadline: taskChunk[1] })
                }
            }
        }
    })

    const dayLookup = {
        1: "Mon",
        2: "Tue",
        3: "Wed",
        4: "Thu",
        5: "Fri",
        6: "Sat",
        7: "Sun"
    };

    function makeTaskArrayTime() {
        // current day stuff

        var currentDay = new Date();
        var dd = String(currentDay.getDate()).padStart(2, '0');
        var mm = String(currentDay.getMonth() + 1).padStart(2, '0');
        var yyyy = currentDay.getFullYear();
        currentDay = mm + '/' + dd + '/' + yyyy;

        let currWeekNum = new Date(yyyy,mm - 1,dd).getWeek()
        let currDayOfWeek = dayLookup[new Date().getDay()]

        // get the deadline date from org

        let deadlineDate = cutStringTimeCard[2].match(/<.*>/g)[0].replaceAll(/<|>/ig, '')
        deadlineDate = deadlineDate.split(" ")[0].split("-")
        let weekNumDeadlineDate = new Date(deadlineDate[0],deadlineDate[1]-1,deadlineDate[2]).getWeek();

        // get the last done date from org
        let lastDoneEntry = cutStringTimeCard[3].match(/\[.*]/g)[0].replaceAll(/\[|\]/ig, '')
        lastDoneEntry = lastDoneEntry.split(" ")[0].split("-")
        let weekNumLastDone = new Date(lastDoneEntry[0],lastDoneEntry[1]-1,lastDoneEntry[2]).getWeek();

        // normal, you havent submitted, before thursday;
        if ((currWeekNum === weekNumDeadlineDate) && (currDayOfWeek !== "Fri" & currDayOfWeek !=="Thu" )) {

            return taskArrayTime.push({taskType:"on_time", taskVal: cutStringTimeCard[1].split("* TODO ")[1], taskDeadline:cutStringTimeCard[2].split('>')[0], taskState: cutStringTimeCard[3]});

            // You have yet to submit and it's thursday
        } else if ((currWeekNum === weekNumDeadlineDate) && (currDayOfWeek==="Thu")) {

            return taskArrayTime.push({taskType:"on_time_thur", taskVal: cutStringTimeCard[1].split("* TODO ")[1], taskDeadline:cutStringTimeCard[2].split('>')[0], taskState:cutStringTimeCard[3]});

            // you have submitted, and a friday submit:
        } else if (currWeekNum === weekNumLastDone) {
            run(`python3 ${py_env_path} RESET on_time`).then((output) => console.log(output))
            return

            // it is friday and you have yet to submit:
        } else if ((currWeekNum === weekNumDeadlineDate) && (currDayOfWeek === "Fri")) {

           // Send text and special display:
           run(`python3 ${py_env_path} INIT urg_fri`).then((output) => console.log(output))
            return taskArrayTime.push({taskType:"urg_fri", taskVal: cutStringTimeCard[1].split("* TODO ")[1], taskDeadline:cutStringTimeCard[2].split('>')[0], taskState:cutStringTimeCard[3]});

        } else if (currWeekNum === weekNumDeadlineDate && (currDayOfWeek == "Sat" | "Sun" )) {
            // Send text and special display:
            run(`python3 ${py_env_path} INIT urg_sat_sun`).then((output) => console.log(output))
            return taskArrayTime.push({taskType:"urg_sat_sun", taskVal: cutStringTimeCard[1].split("* TODO ")[1], taskDeadline:cutStringTimeCard[2].split('>')[0], taskState:cutStringTimeCard[3]});
            // it is monday and you messsed up:
        } else if (currWeekNum > weekNumDeadlineDate) {
            // send another text
            // push 2 tasks to the screen

            return (
            taskArrayTime.push(
                {
                    taskType:"following_mon",
                    taskVal: cutStringTimeCard[1].split("* TODO ")[1],
                    taskDeadline:cutStringTimeCard[2].split('>')[0],
                    taskState:cutStringTimeCard[3]
                },
            ));
        }

    }
    makeTaskArrayTime()

    const listWorkItems = taskArrayWork.map((task, idx) => (
        <ul className={taskStyleTodo}>* TODO
            <ul className={taskStyle}>{task.taskVal}</ul>
            <ul className={taskStyle}>{task.taskDeadline}</ul>
        </ul>
    ));

    const listTimeItems = taskArrayTime.map((task, idx) => {
        if (task.taskType === "on_time") {
            return (
                <ul className={taskStyleTodo}>* TODO
                <ul className={taskStyle}>{task.taskVal}</ul>
                <ul className={taskStyle}>{task.taskDeadline}</ul>
                </ul>
            )
        }
        if (task.taskType === "on_time_thur") {
            return (
                <ul className={taskStyleTodo_thurs}> >>>>>TODO
                <ul className={taskStyle}>{task.taskVal}</ul>
                <ul className={taskStyle}>{task.taskDeadline}</ul>
                </ul>
            )
        }
        if (task.taskType === "urg_fri") {
            return (
                <ul className={taskStyleTodo_urg_fri}> >>>>>>>TODO>>TODAY>>>>>>>>>>>
                <ul className={taskStyle}>{task.taskVal}</ul>
                <ul className={taskStyle}>{task.taskDeadline}</ul>
                </ul>
            )
        }
        if (task.taskType === "urg_sat_sun") {
            return (
                <ul className={taskStyleTodo_urg_sat_sun}> >>>>>>>TODO>>TODAY>>>>>>>>>>>
                <ul className={taskStyle}>{task.taskVal}</ul>
                <ul className={taskStyle}>{task.taskDeadline}</ul>
                </ul>
            )
        }
    });


    return (
        <div className={background}>
            <h1 className={header}>Tasks</h1>
                {listWorkItems}
            <div className={taskBox}>
            </div>
            <div className={taskBox}>
                {listTimeItems}
            </div>
        </div>
    )
}

