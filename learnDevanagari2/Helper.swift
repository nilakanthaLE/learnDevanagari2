//
//  Helper.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 04.11.17.
//  Copyright © 2017 Matthias Pochmann. All rights reserved.
//

import Foundation

//MARK: Array helper
func getIndex(for  string:String,in array:[[String]])->(x:Int,y:Int)?{
    let selArray    = getArray(forTitle: string, inArray: array)
    return getIndex(forSelectedArray: selArray)
}

func getTitle(forTag tag:Int,inArray array:[[String]]) -> String?{
    let index               = getIndex(forTag: tag, inArray: array)
    return index == nil ? nil : array[index!.x][index!.y]
}
func getIndex(forTag tag:Int,inArray array:[[Any]])->(x:Int,y:Int)?{
    let array = getSelectedArray(forTag: tag, inArray: array)
    return getIndex(forSelectedArray: array)
}
func getIndex(forSelectedArray array:[[Any?]]) -> (x:Int,y:Int)?{
    guard array.count > 0  else {return nil}
    return array.enumerated().reduce((x:0,y:0)){ ergebnis, row in
        let x = row.offset
        return row.element.enumerated().reduce(ergebnis){ ergebnis, dataPoint in
            let y = dataPoint.offset
            return dataPoint.element != nil ? (x,y) : ergebnis
        }
    }
}
func getTag(forSelected selected:[[Any?]]?) -> Int{
    guard let selected = selected else {return -1}
    return selected.enumerated().reduce(-1){ ergebnis, row in
        let x = row.offset
        return row.element.enumerated().reduce(ergebnis){
            ergebnis, dataPoint in
            let y = dataPoint.offset
            return ergebnis  < 0 && dataPoint.element != nil ? getTag(for: (x: x, y: y), in: selected) ?? -1 : ergebnis
        }
    }
}
func getTag(for index:(x:Int,y:Int), in array:[[Any?]]) -> Int?{
    var outOfBounds = false
    let tag = array.enumerated().reduce(0){(ergebnis,row) in
        let rowID = row.offset
        return row.element.enumerated().reduce(ergebnis) { (ergebnis, dataPoint) in
            var toAdd:Int{ return row.offset < index.x ||  row.offset == index.x  && dataPoint.offset < index.y ? 1 : 0 }
            outOfBounds = outOfBounds == true ? true : index.x >= array.count || (row.offset == index.x  && index.y >= row.element.count)
            return ergebnis + toAdd
        }
    }
    return outOfBounds ? nil : tag
}
func getSelectedArray(forTag tag:Int,inArray array:[[Any]]) -> [[Any?]]{
    return array.enumerated().map{
        let x = $0.offset
        return $0.element.enumerated().map{
            let y       = $0.offset
            let iTag    = getTag(for: (x: x, y: y), in: array)
            return iTag == tag ? $0.element : nil
        }
    }
}
func getArray(forTitle title:String?,inArray array:[[String]]) -> [[String?]]{ return array.map{$0.map{$0  == title ? $0 : nil}} }
