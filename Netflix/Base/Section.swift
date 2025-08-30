struct Section {
    var layoutType: SectionLayoutType?
    var rows: [Any]?
    
    init(layoutType: SectionLayoutType? = .vertical, rows: [Any]? = nil) {
        self.layoutType = layoutType
        self.rows = rows
    }
}
