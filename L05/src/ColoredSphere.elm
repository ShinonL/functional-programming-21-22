
module ColoredSphere exposing (..)

type alias Point = {x: Int, y: Int, z: Int}
type Color = Red | Green | Blue

type alias ColoredSphere = {center: Point, color: Color, radius: Int}

moveUpdate : ColoredSphere -> Int -> Int -> ColoredSphere
moveUpdate ({center} as sphere) dx dy =
    { sphere 
        | center = 
            { center 
                | x = center.x + dx
                , y = center.y + dy
            }
    }