class: center, middle

# Re-Implementing Material Components for the Web in Elm

Alexander Foremny

Freelance software engineer,<br>
Full Stack web developer

27.02.2018, Hamburg

---

# Material Components Web

*from [MDC Web's GitHub](https://github.com/material-components/material-components-web/)*:

- Production-ready components consumable in an a-la-carte fashion
- Best-in-class performance and adherence to the Material Design guidelines
- Seamless integration with other JS frameworks and libraries


--

- Browser support: last two version of every major browser
  - Chrome
  - Safari
  - Firefox
  - IE 11/Edge
  - Opera
  - Mobile Safari
  - Chrome on Android

---

# elm-mdc

- Re-implementation of MDC Web in pure Elm¹
- Full coverage of components in current version¹

.footnote[¹: *almost*]

--

## … but also

- Not yet on package.elm-lang.org
- Uses `CustomEvent` and `MutationObserver`
- Needs more work to meet MDC Web's performance and browser support

---

# History

- elm-mdl implements [Material Design Lite](https://github.com/google/material-design-lite)…
- …which has been discontinued by Google in 2017

--

## Goals

- Re-implement JavaScript in pure Elm
- Use upstream's CSS *verbatim*

---

# Table of contents

1. Demonstration
1. Using the library
   1. Code Example
   1. `view` Signature
   1. `lift` Pattern
1. Obstacles in Elm
   1. Multiple Event Listeners
   1. CSS Variables
   1. Changing Focus
   1. Trapping Focus
   1. DOM Decoding
   1. Node Initialization
   1. Ticking Components
   1. Global Events
   1. Fun with Work-Arounds

---

# 1. Demonstration

<iframe src="https://aforemny.github.io/elm-mdc" class="demo-iframe"></iframe>

---

# 1. Component Button

<iframe src="https://aforemny.github.io/elm-mdc/#buttons" class="demo-iframe"></iframe>

---

# 1. Component Card

<iframe src="https://aforemny.github.io/elm-mdc/#cards" class="demo-iframe"></iframe>

---

# 1. Component Checkbox

<iframe src="https://aforemny.github.io/elm-mdc/#checkbox" class="demo-iframe"></iframe>

---

# 1. Component Dialog

<iframe src="https://aforemny.github.io/elm-mdc/#dialog" class="demo-iframe"></iframe>

---

# 1. Component Drawer (Temporary)

<iframe src="https://aforemny.github.io/elm-mdc/#temporary-drawer" class="demo-iframe"></iframe>

---

# 1. Component Drawer (Persistent)

<iframe src="https://aforemny.github.io/elm-mdc/#persistent-drawer" class="demo-iframe"></iframe>

---

# 1. Component Drawer (Permanent Above)

<iframe src="https://aforemny.github.io/elm-mdc/#permanent-drawer-above" class="demo-iframe"></iframe>

---

# 1. Component Drawer (Permanent Below)

<iframe src="https://aforemny.github.io/elm-mdc/#permanent-drawer-below" class="demo-iframe"></iframe>

---

# 1. Component Elevation

<iframe src="https://aforemny.github.io/elm-mdc/#elevation" class="demo-iframe"></iframe>

---

# 1. Component Floating Action Button

<iframe src="https://aforemny.github.io/elm-mdc/#fab" class="demo-iframe"></iframe>

---

# 1. Component Grid List

<iframe src="https://aforemny.github.io/elm-mdc/#grid-list" class="demo-iframe"></iframe>

---

# 1. Component Icon Toggle

<iframe src="https://aforemny.github.io/elm-mdc/#icon-toggle" class="demo-iframe"></iframe>

---

# 1. Component Layout Grid

<iframe src="https://aforemny.github.io/elm-mdc/#layout-grid" class="demo-iframe"></iframe>

---

# 1. Component Linear Progress

<iframe src="https://aforemny.github.io/elm-mdc/#linear-progress" class="demo-iframe"></iframeclass="demo-iframe"></iframe>

---

# 1. Component List

<iframe src="https://aforemny.github.io/elm-mdc/#lists" class="demo-iframe"></iframe>

---

# 1. Component Menu

<iframe src="https://aforemny.github.io/elm-mdc/#menu" class="demo-iframe"></iframe>

---

# 1. Component Radio Button

<iframe src="https://aforemny.github.io/elm-mdc/#radio-buttons" class="demo-iframe"></iframe>

---

# 1. Component Ripple

<iframe src="https://aforemny.github.io/elm-mdc/#ripple" class="demo-iframe"></iframe>

---

# 1. Component Select

<iframe src="https://aforemny.github.io/elm-mdc/#select" class="demo-iframe"></iframe>

---

# 1. Component Slider

<iframe src="https://aforemny.github.io/elm-mdc/#slider" class="demo-iframe"></iframe>

---

# 1. Component Snackbar

<iframe src="https://aforemny.github.io/elm-mdc/#snackbar" class="demo-iframe"></iframe>

---

# 1. Component Switch

<iframe src="https://aforemny.github.io/elm-mdc/#switch" class="demo-iframe"></iframe>

---

# 1. Component Tab

<iframe src="https://aforemny.github.io/elm-mdc/#tabs" class="demo-iframe"></iframe>

---

# 1. Component Text Field

<iframe src="https://aforemny.github.io/elm-mdc/#text-field" class="demo-iframe"></iframe>

---

# 1. Component Theme

<iframe src="https://aforemny.github.io/elm-mdc/#theme" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Default)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/default-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Fixed)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/fixed-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Fixed w/ Menu)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/menu-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Waterfall)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/waterfall-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Flexible)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/default-flexible-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Waterfall + Flexible)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/waterfall-flexible-toolbar" class="demo-iframe"></iframe>

---

# 1. Component Toolbar (Fixed Row)

<iframe src="https://aforemny.github.io/elm-mdc/#toolbar/waterfall-toolbar-fix-last-row" class="demo-iframe"></iframe>

---

# 1. Component Typography

<iframe src="https://aforemny.github.io/elm-mdc/#typography" class="demo-iframe"></iframe>

---

# 2. Using the library

<iframe src="example/index.html" class="demo-iframe"></iframe>

---

# 2.1 Code Example

```elm
module Main exposing (..)

import Html.Attributes as Html
import Html exposing (Html, text)
import Material
import Material.Button as Button
import Material.Options as Options

main : Program Never Model Msg
main =
    Html.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


type alias Model =
    { mdl : Material.Model
    , count : Int
    }
```

---


```elm
defaultModel : Model
defaultModel =
    { mdl = Material.defaultModel
    , count = 0
    }


type Msg
    = Mdl (Material.Msg Msg)
    | Increment
    | Decrement


init : ( Model, Cmd Msg )
init =
    ( defaultModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions =
    Material.subscriptions Mdl


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model
```

---

```elm
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ Html.style
              [ ( "display", "flex" )
              , ( "padding", "48px" )
              ]
        ]
        [
          Button.render Mdl [0] model.mdl
              [ Button.ripple
              , Button.stroked
              , Options.onClick Decrement
              ]
              [ text "Decrement"
              ]
        ,
          Html.span
              [ Html.style
                    [ ( "font-size", "1.75rem" )
```

---

```elm
                    , ( "margin", "0 2rem" )
                    ]
              ]
              [ text (toString model.count)
              ]
        ,
          Button.render Mdl [1] model.mdl
              [ Button.ripple
              , Button.stroked
              , Options.onClick Increment
              ]
              [ text "Increment"
              ]
        ]
        |> Material.top
```

---

# 2.2 `view` Signature

## `Material.Model`

```elm
type alias Model = 
    { button : Indexed Button.Model
    , checkbox : Indexed Checkbox.Model
    , dialog : Indexed Dialog.Model
    , …
    }


type alias Indexed a =
    Dict Index a


type alias Index =
    List Int
```

---

# 2.2 `view` Signature

```elm
Button.render
    : (Material.Msg m -> m)       -- (1) lift
    -> Index                      -- (2) unique identifier within `Material.Model`
    -> Material.Model             -- (3)
    -> List (Button.Property m)   -- (4) fancy Html attributes
    -> List (Html m)              -- (5) child nodes
    -> Html m
```

```elm
Html.button
    : List (Html.Attribute m)     -- (4) regular attributes
    -> List (Html m)              -- (5) child nodes
    -> Html m
```

---

# 2.3 `lift` pattern

```elm
type Msg         -- user message
    = ButtonMsg Button.Msg
    | Click


type Button.Msg   -- component message
    = Focus
    | Blur


view _ =
    Html.button
        [ Html.Attributes.onFocus (ButtonMsg Focus)   -- internal events
        , Html.Attributes.onBlur (ButtonMsg Blur)     -- internal events
        , Html.Attributes.onClick Click               -- user event
        ]
        [ text "Click me"
        ]
```

- Components emit events of type `ButtonMsg` (internal) as well as `Msg` (user)
- They need a function `lift = ButtonMsg : ButtonMsg -> Msg`
- `Html.map : (a -> m) -> Html a -> Html m` does not suffice
- This pattern makes sense outside of elm-mdc

---

# 3. Obstacles in Elm

## Implementation of MDC Web

- Implemented in JavaScript and CSS with SASS support
- Fully independent components
- Easy integration with foundation.js and adapter.js
- Uses CSS variables
- Initialization via MdcAutoInit
- Themeability via SASS or CSS variables

---

# 3. Obstacles in Elm

1. Multiple Event Listeners
1. CSS Variables
1. Changing Focus
1. Trapping Focus
1. DOM Decoding
1. Node Initialization
1. Ticking Components
1. Global Events
1. Fun with Work-Arounds

---

# 3.1 Multiple Event Listeners

```elm
type alias Model =
    { msgs : List Msg
    }


type Msg
    = Foo
    | Bar


view : Model -> Html Msg
view model =
    Html.button
        [ Html.onClick Foo
        , Html.onClick Bar
        ]
        [ text "Send"
        ]
```

---

# 3.1 Multiple Event Listeners

<iframe src="event-listeners/index.html" class="demo-iframe"></iframe>

---

# 3.1 Multiple Event Listeners

- Elm does not support multiple event listeners on HTML elements
- Later occurences override earlier ones
- This is bad for components, because
  1. components require event listeners for styling (ie. `focus`)
  1. users need event listeners for interaction

--

## Solution: `Material.Options.Property`

- We use a custom `Html.Attribute` that wraps event listeners

---

# 3.1 `Material.Property`

We collect multiple event listeners and turn them into a single one. We then
dispatch those messages from `update` via `Cmd`s.

```elm
    [ Options.onClick Foo
    , Options.onClick bar
    ]

-- becomes:

    [ Html.onClick (Dispatch [Foo, Bar])
    ]

-- dispatch:

update msg model =
    case msg of
        Dispatch msgs ->
            ( model, Cmd.batch (List.map cmd msgs) )
```

---

# 3.1 `Material.Property`

```elm
collect : List (Decoder Msg) -> Decoder (List Msg)
collect decoders =
    let
        step decoder listDecoder =
            Json.map2 (::) decoder listDecoder
    in
    List.foldl step (Json.succeed []) decoders
```

```elm
forward : List Msg -> Cmd Msg
forward msgs =
    Cmd.batch (List.map cmd msgs)


cmd : Msg -> Cmd Msg
cmd msg =
    Task.perform (\ _ -> msg) <|
    Task.succeed ()
```

---

# 3.1 `Material.Property`


```elm
delayedCmd : Time -> Msg -> Cmd Msg
delayedCmd time msg =
    Task.perform (\ _ -> msg) <|
    Process.sleep time
```

---

# 3.1 `Material.Property`

Convenience functions:

```elm
cs : String -> Property c m             -- Html.class


css : String -> String -> Property c m  -- inline CSS, Html.style


styled
    : (List (Html.Attribute m) -> List (Html m) -> Html m)
    -> List (Property c m)
    -> List (Html m)
    -> Html m
```

```elm
import Material.Options as Options exposing (styled, cs, css, when)

fancyButton =
    styled Html.button
        [ cs "fancy-button"
        , css "background-color" "pink"
        , when isDisabled <|
          Options.attribute (Html.disabled "disabled")
        ]
```

---

# 3.2 CSS Variables

- Elm does not support CSS variables…
- …but MDC Web components use them *not only* for themeing

--

## Soluation: Inline `<style>`

---

# 3.2 CSS Variables

```elm
cssVariables
    : { rippleFgSize : Float
      , rippleFgScale : Float
      , rippleTop : Float
      , rippleLeft : Float
      , rippleFgTranslateStart : Float
      , rippleFgTranslateEnd : Float
      }
    -> { className : String
       , styles : Html m
       }
```

```elm
view _ =
    let
        { className, styles } =
            cssVariables { … }
    in
    styled Html.div
    [ cs "mdc-ripple", cs className ]
    [ …, style ]
```

---

# 3.2 CSS Variables

```elm
cssVariables vars =
    let
        className =
            "mdc-ripple-style-hack-" ++ hash vars

        hash vars = -- unique identifier from values of all variables
            …

        style =
            Html.node "style"
            [ Html.type_ "text/css"
            ]
            [ text """
.""" ++ className ++ { """ ++
    /* write out vars */
++ """ }
              """
            ]
    in
    { className = className
    , styles = styles
    }
```

---

# 3.3 Changing Focus

- Some MDC Web components focus child elements, ie. Menu
- Elm requires unique `Html.id`s…
- …and I am not sure that is the way to go. . .

--

## Possible solution within elm-mdc.js

- Use `MutationObserver` to observe `data-autofocus` attributes

---

# 3.4 Trapping Focus

- Some MDC Web components trap focus, ie. Dialogs
- Trapping focus is dependent on the framework
- They recommend davidtheclark/focus-trap

--

## Possible solution within elm-mdc.js

- Use `MutationObserver` to observer `data-focustrap` attributes
- It seems we can use davidtheclark/focus-trap as well

---

# 3.5 DOM Decoding

- MDC Web components frequently require information from DOM, ie. `offsetWidth`

--

## Solution: Use `Json.Decoder`

---

# 3.5 DOM Decoding

```elm
import Json.Decode as Json


type Msg
    = Click { offsetWidth : Int, offsetHeight : Int }


view _ =
    Html.button
        [ Html.on "click" (Json.map Click decodeGeometry)
        ]
        [ text "Decode!"
        ]


decodeGeometry : Decoder { offsetWidth : Int, offsetHeight : Int }
decodeGeometry =
    Json.at [ "target" ] <|
    Json.map2 (\ offsetWidth offsetHeight ->
            { offsetWidth = offsetWidth, offsetHeight = offsetHeight }
        )
        (Json.at [ "offsetWidth" ] Json.int)
        (Json.at [ "offsetHeight" ] Json.int)
```

---

# 3.5 DOM Decoding

- Works well. Most frequently we require information from DOM when user
  interaction happens
- It is safe in Elm. `Decoder a` only produces a value when *run*
- Using *continuation passing style* you can turn this into a library
  (see [`debois/elm-dom`](https://package.elm-lang.org/packages/debois/elm-dom/latest))

--

## …but

- Limited to properties. No functions, ie. no `getBoundingClientRect()`
- Limited to decoding DOM when events happen
- Decoders fail silently

---

# 3.5 DOM Decoding

## Component "Grid List"

- Decodes container's and its wrapped children `offsetWidth` to horizontally
  center itself

```elm
decodeGeometry =
    DOM.target <|
    Json.map2 Geometry DOM.offsetWidth <|
        ( DOM.childNode 0 <|
          DOM.childNode 0 <|
          DOM.offsetWidth
        )
```

---

# 3.5 DOM Decoding

## Component "Menu"

- Decodes it's dimensions, position and viewport extents to automatically
  position itself

```elm
anchorRect =
    DOM.parentElement DOM.boundingClientRect


viewport =
    Json.at ["target", "ownerDocument", "defaultView"] <|
    Json.map2 Viewport
        (Json.at ["innerWidth"] Json.float)
        (Json.at ["innerHeight"] Json.float)
```

---

# 3.5 DOM Decoding

## Component "Ripple"

- Decodes window's page offset, container's `disabled` property and `changedTouches`

```elm
changedTouches =
    Json.at ["changedTouches"] << Json.list <|
    Json.map2 (\ pageX pageY -> { pageX = pageX, pageY = pageY })
        (Json.at ["pageX"] Json.float)
        (Json.at ["pageY"] Json.float)

disabled =
    Json.oneOf
    [ Json.at ["target", "disabled"] Json.bool
    , Json.succeed False
    ]
```

---

# 3.5 DOM Decoding

## Component "Select"

- In addition to Menu, decodes item's `offsetTop`s for positioning

```elm
itemOffsetTops =
    DOM.target <|                  -- .mdc-select
    DOM.childNode 1 <|             -- .mdc-select__menu.mdc-menu
    DOM.childNode 0 <|             -- .mdc-menu__items
    DOM.childNodes DOM.offsetTop   -- .mdc-menu__item
```

---

# 3.5 DOM Decoding

## Component "Slider"

- Raises events on several DOM nodes and needs to traverse to the container to
  decode `Geometry`

```elm
hasClass class =
    Json.map ( \className ->
          String.contains (" " ++ class ++ " ") (" " ++ className ++ " ")
      )
      (Json.at [ "className" ] Json.string)


traverseToContainer decoder =
    hasClass "mdc-slider"
    |> Json.andThen (\ doesHaveClass ->
        if doesHaveClass then decoder else
            DOM.parentElement (Json.lazy (\ _ -> traverseToContainer decoder))
    )
```

---

# 3.5 DOM Decoding

## Component "Textfield"

- Would like to decode `border-radius`

```elm
-- I have not checked that yet. Currently hard-coded.
```

---

# 3.5 DOM Decoding

## `DOM.boundingClientRect`

- Only emulates `getBoundingClientRect()`
- Traverses all `offsetParents` and accumulates `offset{Top,Left}` and `scroll{Top,Left}`
- Does not work when static parents are scrolled
- Is computationally expensive
- Returns slightly different results depending on browser

--

## Possible solution and work-around

- Elm should have `getBoundingClientRect : Decoder Rect`
- Supplement `globaltick` event

---

# 3.6 Node initialization

*Recall: DOM decoding only works in response to events*

- MDC components frequently decode DOM when *initializing*
  - performance
  - but also Grid List

- Elm's component initialization is
  - different from traditional JavaScript
  - is tricky because of VirtualDOM

--

## Solution: MutationObserver + CustomEvent

---

# 3.6 Node Initialization

- We supplement `elm-mdc.js`
- `MutationObserver` observes the `data-globaltick` attribute
- Sends a `CustomEvent` `"globaltick"`
- Components which require initialization set:

```elm
styled Html.div
    [ when (model.geometry == Nothing) << Options.many <|
          [ Options.data "globaltick" ""
          , Options.on "globaltick" (Json.map Init decodeGeometry)
          ]
    ]
```

--

This solution is *robust* because it

- depends on `Model` rather than DOM
- works reliably throughout the application's life-span

---

# 3.7 Ticking Components

*Recall: DOM decoding only works in response to events*

*Recall: We can decode DOM upon node insertion (`globaltick`)*

--

- Sometimes we need to run a decoder *one animation frame after* an event
  occured (ie. Menu)

--

```elm
update msg model =
    case msg of
        Open ->           -- user event is fired
            ( { model | animating = True, geometry = Nothing }, Cmd.none )

        Init geometry ->  -- view update happens 1 frame later
            ( { model | geometry = Just geometry }, Cmd.none )


view _ =
    styled Html.div
        [ when (model.animating && model.geometry == Nothing) <|
          GlobalEvents.onTick (Json.map Init decodeGeometry)
        ]
```

---

# 3.8 Global Events

- Sometimes we need to run a decoder in response to an event on `window` or
  `document`, ie. resize or mouse events
- subscriptions do not allow for DOM decoding

--

## Solution: CustomEvents

- Supplement `elm-mdc.js`
- Add global event listener `window.onresize`
- On resize, find all nodes that set `data-globalresize` and dispatch a custom
  `"globalresize"` event
- Similar with mouse, pointer and touch events

---

# 3.9 Fun with Work-Arounds

<iframe src="https://aforemny.github.io/elm-mdc/#checkbox" class="demo-iframe"></iframe>

---

# 3.9 Fun with Work-Arounds

```elm
type Model =
    { lastKnownState : State
    , animation : Maybe String
    }


type alias State =
    { checked : Bool
    , indeterminate : Bool
    , disabled : Bool
    }


type Msg
    = Animate State State
```

---

```elm
animationClass oldState newState =
    case ( oldState.checked, newState.checked ) of
        ( False, True ) ->
            "mdc-checkbox--animation-unchecked-checked"
        …


update msg model =
    case msg of
        Animate oldState newState ->
            let
                animation =
                    animationClass oldState newState
            in
            ( { model
                  | lastKnownState = newState
                  , animation = Just animation
              }
            ,
              Cmd.none
            )
```

---


```elm
view config … =
    let
        currentState =
            model.lastKnownState
            |> Maybe.withDefault defaultState

        configState =
            stateFromConfig config

        stateChanged =
            currentState /= configState
    in
    styled Html.div
        [ cs "mdc-checkbox"
        , when stateChanged <|
          GlobalEvents.onTick (Animate currentState configState)
        , animationClass model.animation
        ]
        [ …
        ]
```

---

# Thank you for your attention.

## Special thanks to Søren Debois, Ville Penttinen and Håkon Rossebø who I worked closely with on elm-mdl.

### Many thanks to all the contributors to elm-mdl and elm-mdc.

---

# Contact Information

WWW: [https://foremny.me](foremny.me)<br>
E-Mail: [aforemny@posteo.de](mailto:aforemny@posteode)<br>
GitHub: [github.com/aforemny](https://github.com/aforemny)<br>
Slack: @aforemny
