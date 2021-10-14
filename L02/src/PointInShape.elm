module PointInShape exposing (..)

type alias Point = { x: Float, y: Float }
type Shape2D
    = Circle { center: Point, radius: Float }
    | Rectangle { topLeftCorner: Point, bottomRightCorner: Point }
    | Triangle { pointA: Point, pointB: Point, pointC: Point }

pointInShape: Point -> Shape2D -> Bool
pointInShape point shape =
    case shape of
        Circle { center, radius } -> computeDistance point center < radius
        Rectangle { topLeftCorner, bottomRightCorner } -> 
            (topLeftCorner.x < point.x && point.x < bottomRightCorner.x) 
            && (bottomRightCorner.y < point.y && point.y < topLeftCorner.y)
        Triangle { pointA, pointB, pointC } -> 
            (heron pointA pointB pointC) == (heron point pointA pointB) + (heron point pointA pointC) + (heron point pointB pointC)


computeDistance: Point -> Point -> Float
computeDistance pointA pointB =
    sqrt((pointA.x - pointB.x) * (pointA.x - pointB.x) + 
        (pointA.y - pointB.y) * (pointA.y - pointB.y))

heron: Point -> Point -> Point -> Float
heron pointA pointB pointC =
    let 
        a = computeDistance pointB pointC
        b = computeDistance pointA pointC
        c = computeDistance pointA pointB
        semiPerimeter = (a + b + c) / 2
    in
        sqrt (semiPerimeter * (semiPerimeter - a) * (semiPerimeter - b) * (semiPerimeter - c))