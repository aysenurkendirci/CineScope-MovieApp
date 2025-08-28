// Base/FormSection.swift
import UIKit

final class FormSection {
    var rows: [Any] = []   // Cell değil, ViewModel tut
    init(rows: [Any] = []) {
        self.rows = rows
    }
}
