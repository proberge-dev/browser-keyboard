## Browser Keyboard

This package hopes to bring you the ability to intercept and use keyboard events.
These events are global and use the subscription model, they can be used to intercept
and act upon key presses of different types.
Great for games, shortcuts and all sorts of functionality.


## Here is an example of how to use this package:

```elm
-- Suppose a msg where you do something when the user presses A
type Msg = PressedA | DoNothing

subs model =
    Browser.Keyboard.onKeyUp
        (\event ->
            if event.key == "A" then
                PressedA
            else
                DoNothing
        )
```
