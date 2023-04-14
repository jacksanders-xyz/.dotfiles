* TODO Submit Time cards
 DEADLINE: <2023-04-13 Thu ++1w>
   :PROPERTIES:
   :LAST_REPEAT: [2023-04-07 Fri 12:18]
   :END:
  - State "DONE" from "TODO" [2023-04-07 Fri 12:18]
   - State "DONE" from "TODO" [2023-04-06 Thu 20:40]



DeadlineWeekNum is what the current week num is
LastNumEntry is the week num of the last time you hit done

[*] if DeadlineWeekNum == LastNumEntry then it is this week and you have submitted >> push nothing

[*] if DeadlineWeekNum > LastNumEntry by 1, and CurrentDateNum !> lastNumEntry by 2 then it is the current week and have not yet submitted >> push the TODO

[*] if current_datenum > LastNumEntry by 2 & deadline > 1, then it is the monday of the next week and you have not submitted, send text message



you have yet to submit this week:
    - monday - before thurs: D=15 L=14 C=15 so if C == D we are in the new week
You just submitted:
    - before on thu: D=16 L=15 C=15  (D - L = 1) C =
    - after thu: D=15 L=14 C=15  (D - L = 1)
you have submitted this week:
    - on thu: D=16 L=15 C=15  (D - L = 1)
Correct, but on friday
    - before on fri: D=15 L=14 C=15 (CD=friday), send text
    - after on fri: D=16 L=15 C=15 (CD=friday)
you fucked up, it is saturday, send another text
    - on sat: D=16 L=15 C = 16 (CD=saturday)
    - text

you fucked up last week, it is monday
    - on monday: D=16, L=15, C = 16 (CD=monday)
    - don't delete from the task list


You need to make it so that the Two could possibly be displayed

week num     14 14 14 14 14 14 14 15 15 15 15 15 15 15 16 16 16 16 16 16 16                          *
                                           D                                       ]
                      L                                                               ]
                                                 C                                    ]
             0  1  2  3  4  5  6  0  1  2  3  4  5  6  0  1  2  3  4  5  6
             m  t  w  T  f  s  S  m  t  w  T  f  s  S  m  t  w  T  f  s  S


wrapping the period on thursday:
CURR
DeadlineWeekNum
LastNumEntry

you have yet to submit this week:
    - on thu: D=16 L=15 C=15  (D - L = 1) is plus 1 >> push to the array
you have submitted this week:
    - on thu: D=17 L=16 C=16  (D - L = 1) is plus 1 >> return nothing
Correct, but on friday
    - before D=16 L=15 C=16 (CD=friday) >> push to the array
    - after D=17 L=16 C=16              >> return nothing
you fucked up, it is saturday, send another text
    - before on sat: D=16 L=15 C =16 (CD=saturday)
    - after on sat: D= 17 L=16 C=16 (CD=saturday

you fucked up last week, it is monday
    - on monday: D=16, L=15, C=16 (CD=monday)
    - don't delete from the task list


week num     14 14 14 15 15 15 15 15 15 15 16 16 16 16 16 16 16 17 17 17 17
                                           D                                          ]
                      L                                                               ]
                                        C                                             ]
             0  1  2  3  4  5  6  0  1  2  3  4  5  6  0  1  2  3  4  5  6
             m  t  w  T  f  s  S  m  t  w  T  f  s  S  m  t  w  T  f  s  S

you need to make a current Day, and a current week tracker


late st8;
```
* TODO Submit Time cards
 DEADLINE: <2023-04-13 Thu ++1w>
   :PROPERTIES:
   :LAST_REPEAT: [2023-04-07 Fri 12:18]
   :END:
  - State "DONE" from "TODO" [2023-04-07 Fri 12:18]
   - State "DONE" from "TODO" [2023-04-06 Thu 20:40]
```



on_time:
```
* TODO Submit Time cards
 DEADLINE: <2023-04-20 Thu ++1w>
   :PROPERTIES:
   :LAST_REPEAT: [2023-04-13 Thu 20:42]
   :END:
  - State "DONE" from "TODO" [2023-04-13 Thu 20:42]
  - State "DONE" from "TODO" [2023-04-07 Fri 12:18]
   - State "DONE" from "TODO" [2023-04-06 Thu 20:40]
```


















