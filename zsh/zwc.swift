import Foundation
import NaturalLanguage

var fileCount = 0
var lineCount = 0
var wordCount = 0
var hanCharacterCount = 0
var characterCount = 0
var nonWhitespaceCharacterCount = 0
let tokenizer = NLTokenizer(unit: .word)
let hanRegex = try! NSRegularExpression(pattern: "\\p{Han}")

for path in CommandLine.arguments.dropFirst() {
    do {
        let text = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
        fileCount += 1
        lineCount += text.reduce(0) { $1 == "\n" ? $0 + 1 : $0 }
        characterCount += text.count
        nonWhitespaceCharacterCount += text.reduce(0) { $1.isWhitespace ? $0 : $0 + 1 }
        hanCharacterCount += hanRegex.numberOfMatches(
            in: text,
            range: NSRange(text.startIndex..<text.endIndex, in: text)
        )

        tokenizer.string = text
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { _, _ in
            wordCount += 1
            return true
        }
    } catch {
        FileHandle.standardError.write(Data("zwc: cannot read \(path): \(error)\n".utf8))
        exit(1)
    }
}

let formatter = NumberFormatter()
formatter.numberStyle = .decimal
formatter.locale = Locale(identifier: "en_US")

func formatted(_ value: Int) -> String {
    formatter.string(from: NSNumber(value: value)) ?? String(value)
}

let rows = [
    ("Files", fileCount),
    ("Lines", lineCount),
    ("Words", wordCount),
    ("Han characters", hanCharacterCount),
    ("Characters", characterCount),
    ("Non-whitespace", nonWhitespaceCharacterCount),
]

for (label, value) in rows {
    let paddedLabel = label.padding(toLength: 15, withPad: " ", startingAt: 0)
    print("\(paddedLabel) \(formatted(value))")
}
