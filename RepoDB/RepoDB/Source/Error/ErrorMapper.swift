//
//  ErrorMapper.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

class ErrorMapper {
    
    static func mapError(_ error: Error) -> RepoDatabaseError {
        guard let databaseError = error as? DatabaseError else { return DataBaseUndefindError() }
        switch databaseError.errorCode {
        case 1: return DataBaseUndefindError()
        case 2: return DatabaseInternalError()
        case 3: return DatabasePermissionError()
        case 4: return DatabaseAbortError()
        case 5: return DatabaseBusyError()
        case 6: return DatabaseLockedError()
        case 7: return DatabaseNoMemoryError()
        case 8: return DatabaseReadOnlyError()
        case 9: return DatabaseInterruptError()
        case 10: return DatabaseIOError()
        case 11: return DatabaseCorruptError()
        case 12: return DatabaseNotFoundError()
        case 13: return DatabaseFullError()
        case 14: return DatabaseCantOpenError()
        case 15: return DatabaserotocolError()
        case 17: return DatabaseSchemaError()
        case 18: return DatabaseTooBigError()
        case 19: return DatabaseConstraintError()
        case 20: return DatabaseMissingMatchError()
        case 21: return DatabaseMissingUseError()
        case 22: return DatabaseNoSlfError()
        case 23: return DatabaseAuthError()
        case 24: return DatabaseFormatError()
        case 25: return DatabaseRangeError()
        case 26: return DatabaseNotADBError()
        case 27: return DatabaseNotIceError()
        case 28: return DatabaseWarningError()
        case 100: return DatabaseRowError()
        default: return DataBaseUndefindError()
        }
    }
}
