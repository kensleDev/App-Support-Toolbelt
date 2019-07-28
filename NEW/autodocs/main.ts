import * as fs from "fs"
import * as util from "util"

init()


function init() {
  const hotkeys = scrapeHotkeys()

  const json = ahkToJson(hotkeys)

  const mdTable = convertJsonToMarkDownTable(json, ['Key', 'Command'])

  const newReadme = replaceReadmeSection(mdTable, '# Hotkeys', '<!--- HotkeyEnd -->')

  writeFile("../README.md", newReadme)
}

// get data

function scrapeHotkeys(): string {

  var contents = fs.readFileSync('../nav.ahk', 'utf8');

  const startIndex: number = contents.indexOf('; -> Hotkeys')
  const finishIndex: number = contents.indexOf('; -<>-|')
  const hotkeys: string = contents.substring(startIndex, finishIndex)

  return hotkeys

}

// ahk

function ahkToJson(hotkeys: string) {
  const { headings, headingIndexes } = extractAhkHeadings(hotkeys)
  const sections = extractAhkSections(hotkeys, headings, headingIndexes)

  return sections
}

function extractAhkHeadings(hotkeys: string): AhkHeadings {
  const hotkeysArr = hotkeys.split("\n")

  const headings = []
  const headingIndexes = []

  hotkeysArr.forEach((line, index) => {
    if (line !== '\r') {

      if (line.substring(0, 4) === '  ; ') {
        const heading = line.substring(4).replace('\r', '')
        headings.push(heading)
        headingIndexes.push(hotkeys.indexOf(heading))
      }
      // console.log(line)
    }
  });

  return {
    headings,
    headingIndexes
  }
}

function extractAhkSections(hotkeys: string, headings: string[], headingIndexes: number[]) {

  const sections = []
  const output = []

  headings.forEach((heading, index) => {
    sections.push(hotkeys.substring(headingIndexes[index], headingIndexes[index + 1]))
  })

  sections.forEach((section, index) => {
    const cleanSection = section.replace(/ /g, '')
    const cleanSectionArr = cleanSection.split("\n")

    let headingLine, lineKeys = []

    cleanSectionArr.forEach((line, index) => {
      if (index === 0) headingLine = line.replace(/\r?\n|\r/g, '')
      if (line.includes('::')) {
        const newLine = line.replace(/\r?\n|\r/g, '').replace(/Send,/g, 'Send, ')
        const key = newLine.substring(0, newLine.indexOf('::')).replace('&', ' & ')
        const command = newLine.substring(newLine.indexOf('::') + 2)
        lineKeys.push({ [key]: command })
      }
    })

    output.push({ [headingLine]: lineKeys })

  })

  return output
}

// markdown

function convertJsonToMarkDownTable(json, tableHeadings) {

  const mdHeadingsArr = []
  const mdHeadingDividerArr = []
  let outputArr = []

  tableHeadings.forEach(heading => {
    mdHeadingsArr.push(`| ${heading} `)
    mdHeadingDividerArr.push('| :-------- ')
  })

  // console.log(mdTableHeaderRow + '\n' + mdTableDividerRow )

  json.forEach((obj, index) => {

    const sectionArr = obj[Object.keys(obj)[0]]
    const mdTableHeader = '## ' + Object.keys(obj)[0]

    const rows = []

    sectionArr.forEach(section => {

      const key = Object.keys(section)[0]
      const value = Object['values'](section)[0]
      const mdTableRow = `| ${key} | ${value} |`

      rows.push(mdTableRow)
    })

    const mdTableHeadingsRow = mdHeadingsArr.join('') + '|'
    const mdTableDividerRow = mdHeadingDividerArr.join('') + '|'
    const mdTableRows = rows.join('\n')

    // console.log(mdTableHeader + '\n' + mdTableHeadingsRow + '\n' + mdTableDividerRow + '\n' + mdTableRows + '\n')
    outputArr.push(mdTableHeader + '\n' + mdTableHeadingsRow + '\n' + mdTableDividerRow + '\n' + mdTableRows + '\n')

  })

  return outputArr.join('\n')

}

// File ops

function writeFile(filename, input) {

  fs.writeFile(filename, input, function (err) {
    if (err) {
      return console.log(err);
    }

    console.log("The file was saved!");
  });

}

function replaceReadmeSection(replacement, startIndexString, finishIndexString) {

  var readme = fs.readFileSync('../README.md', 'utf8');

  const startIndex = readme.indexOf(startIndexString) + startIndexString.length
  const finishIndex = readme.indexOf(finishIndexString)

  const firstHalf = readme.substring(0, startIndex)

  const secondHalf = readme.substring(finishIndex)

  return firstHalf + '\n' + replacement + '\n' + secondHalf

}


// Misc

export interface AhkHeadings {
  headings: string[]
  headingIndexes: number[]
}

function objLog(input) {
  console.log(util.inspect(input, false, null, true /* enable colors */))
}
