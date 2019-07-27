var fs = require('fs');
const util = require('util')


const hotkeys = scrapeHotkeys()

const stringHotkeyData = JSON.stringify(extractJSONData(hotkeys))

const hotkeysMd = convertToMarkDown(stringHotkeyData)

const readme = regenerateReadme(hotkeysMd)

writeFile("../README.md", readme)


function regenerateReadme(hotkeys) {

  var readme = fs.readFileSync('../README.md', 'utf8');

  const startIndex = readme.indexOf('# Hotkeys',)
  const finishIndex = readme.indexOf('<!--- HotkeyEnd -->')

  const firstHalf = readme.substring(0, startIndex)

  const secondHalf = readme.substring(finishIndex)

  const newMd = firstHalf + '\n' + hotkeys + '\n' + secondHalf

  return newMd

}

function convertToMarkDown(jsonString) {

  const sections = JSON.parse(jsonString)
  let markDownString = ''

  // objLog(sections)

  const tableHeadings = ['Key', 'Command']

  let table = `| ${tableHeadings[0]} | ${tableHeadings[1]} |
| :-------- | :--------: |`

  sections.forEach((section, index) => {

    const tableLines = []
    const innerSection = section[Object.keys(section)[0]]

    innerSection.forEach(el => {
      // console.log(el)
      const key = Object.keys(el)[0]
      const value = Object.values(el)[0]

      const mdTableLine = `| ${key} | ${value} |`
      tableLines.push(mdTableLine)

      // console.log(mdTableLine)
    })

    const heading = '## ' + Object.keys(section)[0]
    const body = tableLines.join('\n')
    const tablSection = heading + '\n' + table + '\n' + body + '\n\n'

    // console.log(tablSection)

    markDownString += tablSection

  })

  // console.log(markDownString)

  return markDownString

}

function extractJSONData(hotkeys) {

  const { headings, headingIndexes } = getHeadings(hotkeys)

  const sections = getSections(headings, headingIndexes)

  // console.log(sections)

  // console.log(util.inspect(sections, false, null, true /* enable colors */))

  return sections

}

function getSections(headings, headingIndexes) {

  const sections = []
  const output = []

  headings.forEach((heading, index) => {
    sections.push(hotkeys.substring(headingIndexes[index], headingIndexes[index + 1]))
  })

  sections.forEach((section, index) => {
    const cleanSection = section.replace(/ /g, '')
    cleanSectionArr = cleanSection.split("\n")

    let headingLine, lineKeys = []

    cleanSectionArr.forEach((line, index) => {
      if (index === 0) headingLine = line.replace(/\r?\n|\r/g, '')
      if (line.includes('::')) {
        const newLine = line.replace(/\r?\n|\r/g, '').replace(/Send,/g, 'Send, ')
        const key = newLine.substring(0, newLine.indexOf('::')).replace('&', ' & ')
        const command = newLine.substring(newLine.indexOf('::')+2)
        lineKeys.push({ [key]: command })
      }
    })

    output.push({ [headingLine]: lineKeys })

  })

  return output
}

function getHeadings(hotkeys) {
  hotkeysArr = hotkeys.split("\n")

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

function scrapeHotkeys() {


  var contents = fs.readFileSync('../nav.ahk', 'utf8');

  const startIndex = contents.indexOf('; -> Hotkeys')
  const finishIndex = contents.indexOf('; -<>-|')
  const hotkeys = contents.substring(startIndex, finishIndex)

  return hotkeys

}

function writeFile(filename, input) {

  fs.writeFile(filename, input, function (err) {
    if (err) {
      return console.log(err);
    }

    console.log("The file was saved!");
  });

}


function objLog(input) {
  console.log(util.inspect(input, false, null, true /* enable colors */))
}
