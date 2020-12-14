#Day 11 Part 1
$data = get-content C:\users\chuck\Documents\AdventOfCode\Day11Sample.txt
$dataLen = $data.Length - 1
$seatMap = @{}
for ($i = 0; $i -lt $data.Count; $i++) {

    $seatMap[$i] += $data[$i].ToCharArray()

}
function Get-adjacent {
    param (
        $seat,
        $seatMap
    )
    $maxRow = $seatMap.Count - 1
    $maxColumn = $seatMap[0].count -1

    $adjacents = @()
    for ($x = $seat[0]-1; $x -lt $seat[0]+2; $x++) {
        for ($y = $seat[1]-1; $y -lt $seat[1]+2; $y++) {
            if($x -lt 0 -or $x -gt $maxColumn){
                continue
            }
            if($y -lt 0 -or $y -gt $maxRow){
                continue
            }
            if($x -eq $seat[0] -and $y -eq $seat[1]){
                continue
            }
            $adjacents += [PSCustomObject]@{
                x = $x
                y = $y
            }
        }
    }
    
    return $adjacents
}

function DrawSeatMap {
    param (
        $seatMap
    )

    for ($i = 0; $i -lt $seatMap.Count; $i++) {
        Write-Host ($seatMap[$i] -join '')
    }
    
}

function CompareSeatMaps {
    param (
        $first,
        $second
    )

    for ($i = 0; $i -lt $first.Count; $i++) {
        for ($j = 0; $j -lt $first.Count; $j++) {
            if($first[$i][$j] -ne $second[$i][$j]){
                return $false
            }
        }
    }
    return $true
}
function NextVisable {
    param (
        $A,
        $B
    )

    $next = [PSCustomObject]@{
        x = ($b.x - $a.x) + $b.x
        y = ($b.y - $a.y) + $b.y
    }
    return $next
    
}

function UpdateSeatMap {
    param (
        $seatMap
    )

    $newSeatMap = @{}
    for ($i = 0; $i -lt $seatmap.Count; $i++) {
        $newSeatMap[$i] = $seatMap[$i].Clone()
    }
    for ($x = 0; $x -lt $seatmap.Count; $x++) {
        for ($y = 0; $y -lt $seatmap.Count; $y++) {
            if($seatMap[$y][$x] -eq '.'){
                continue
            }
            $currentSeat = [PSCustomObject]@{
                x = $x
                y = $y
            }
            $adj = Get-adjacent -seat @($x,$y) -seatMap $seatMap
            $occupied = 0
            foreach($seat in $adj){
                if($seatMap[$seat.y][$seat.x] -eq '#'){
                    $occupied++
                }
                if($seatMap[$seat.y][$seat.x] -eq '.'){
                    $adj += NextVisable $currentSeat $seat
                }
            }
            if($seatMap[$y][$x] -eq 'L' -and $occupied -eq 0){
                $newSeatMap[$y][$x] = '#'
            }
            if($seatMap[$y][$x] -eq '#' -and $occupied -gt 4){
                $newSeatMap[$y][$x] = 'L'
            }
        }
    }

    return $newSeatMap
}

function CountOccupiedSeats {
    param (
        $seatmap
    )
    $count = 0
    for ($i = 0; $i -lt $seatmap.Count; $i++) {
        for ($j = 0; $j -lt $seatmap[0].Count; $j++) {
            if($seatmap[$i][$j] -eq '#'){
                $count++
            }
        }
    }
    return $count
}
DrawSeatMap $seatMap
$previousSeatMap = UpdateSeatMap $seatMap

while (-not(CompareSeatMaps $seatmap $previousSeatMap)) {
    DrawSeatMap $previousSeatMap
    Write-Host '----------'
    $seatMap = $previousSeatMap
    $previousSeatMap = UpdateSeatMap $seatMap
}

CountOccupiedSeats $seatMap

#Day 11 Part 2

function CountVisableOccupiedSeats {
    param (
        $seat,
        $seatmap
    )

    #123
    #4 5
    #678
    $maxRow = $seatMap.Count - 1
    $maxColumn = $seatMap[0].count -1

    $x = $seat[0]
    $y = $seat[1]
    $occupied = 0
    $adj = Get-adjacent -seat -seatMap
    foreach ($s in $adj){
        if($seatmap[$s.y][$s.x] -eq '#'){
            $occupied++
        }
        if($seatmap[$s.y][$s.x] -eq '.'){
            
        }
    }
    
}

function IsRealSeat {
    param (
        $seat,
        $seatMap
    )
    $x = $seat[0]
    $y = $seat[1]

    $maxRow = $seatMap.Count - 1
    $maxColumn = $seatMap[0].count -1

    if(-not($x -lt 0 -or $x -gt $maxColumn) -and -not($y -lt 0 -or $y -gt $maxRow) ){
        return $true
    }
    return $false
}

function NextVisable {
    param (
        $A,
        $B
    )

    $next = [PSCustomObject]@{
        x = ($b.x - $a.x) + $b.x
        y = ($b.y - $a.y) + $b.y
    }
    return $next
    
}
