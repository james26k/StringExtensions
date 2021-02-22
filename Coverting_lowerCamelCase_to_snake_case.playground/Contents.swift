
extension String {
    var splitLowercaseStrings: [String] {
        guard self.includesUppercaseChar else { return [self] }
        let (lowercaseString, otherString) = self.dividedLowercaseStringBeforeUppercaseCharAndOther
        let replacedOtherString = otherString.replacedFirstCharWithLowercase
        guard replacedOtherString.includesUppercaseChar else { return [lowercaseString, replacedOtherString] }
        return [[lowercaseString],
                replacedOtherString.splitLowercaseStrings]
            .flatMap { $0 }
    }

    private var includesUppercaseChar: Bool {
        filter { $0.isUppercase }.count != 0
    }

    private var dividedLowercaseStringBeforeUppercaseCharAndOther: (prefixString: String, otherString: String) {
        guard let uppercaseCharIndex = firstIndex(where: { $0.isUppercase }) else { return (self, "") }
        let targetRange = startIndex..<uppercaseCharIndex
        let firstLowercaseString = String(self[targetRange])
        var otherString = self
        otherString.removeSubrange(targetRange)
        return (firstLowercaseString, otherString)
    }

    private var replacedFirstCharWithLowercase: String {
        var string = self
        let firstUppercaseChar = string.first!
        let firstLowercaseChar = firstUppercaseChar.lowercased()
        let secondIndex = string.index(after: string.startIndex)
        string.insert(contentsOf: firstLowercaseChar, at: secondIndex)
        return String(string.dropFirst())
    }
}

let ordinalNumbers = "firstSecondThirdFourthFifthSixth"

print("dotCase: \(ordinalNumbers.splitLowercaseStrings.joined(separator: "."))")
// dotCase: first.second.third.fourth.fifth.sixth
print("snakeCase: \(ordinalNumbers.splitLowercaseStrings.joined(separator: "_"))")
// snakeCase: first_second_third_fourth_fifth_sixth


