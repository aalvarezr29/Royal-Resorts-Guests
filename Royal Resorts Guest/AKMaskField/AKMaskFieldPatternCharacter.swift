//
//  AKMaskFieldPatternCharacter.swift
//  AKMaskField
//  GitHub: https://github.com/artemkrachulov/AKMaskField
//
//  Created by Artem Krachulov
//  Copyright (c) 2016 Artem Krachulov. All rights reserved.
//  Website: http://www.artemkrachulov.com/
//

/// Single block character pattern constant.

public enum AKMaskFieldPatternCharacter: String {
    
    //  MARK: - Constants
    
    case NumberDecimal = "d"
    case NonDecimal    = "D"
    case NonWord       = "W"
    case Alphabet      = "a"
    case AnyChar       = "."
    case Number        = "q"
    case Day           = "r"
    case Mon           = "z"
    case Year          = "y"
    /// Returns regular expression pattern.
    
    public func pattern() -> String {
        switch self {
        case .NumberDecimal   : return "\\d"
        case .NonDecimal      : return "\\D"
        case .NonWord         : return "\\W"
        case .Alphabet        : return "[a-zA-Z]"
        case .Number          : return "[0-9]"
        case .Day             : return "[1-9]"
        case .Mon             : return "[0-1]"
        case .Year            : return "[0-2]"
        default               : return "."
        }
    }
}
