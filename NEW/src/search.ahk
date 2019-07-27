searchInputBank() {
  THE_MENU=--Input--`n(a)-Google`n(s)-StackOverFlow`n(d)-Twitter`n(z)-Youtube`n(x)-Reddit`n
  ToolTip, %THE_MENU%

  Input Key, L1
    ToolTip
    If Key=a
      querySearch("Google", "input", "http://www.google.com/search?q=")
    Else If Key=s
      querySearch("Stack Overflow", "input", "https://stackoverflow.com/search?q=")
    Else If Key=d
      querySearch("Twitter", "input", "https://twitter.com/search?q=")
    Else If Key=z
      querySearch("YouTube", "input", "https://www.youtube.com/search?q=")
    Else If Key=x
      querySearch("Reddit", "input", "https://www.reddit.com/search?q=")
    Else If Key=c
      ; querySearch("Comm Requests", "input", "http://it32:8081/api/DCS/REQUESTS/")
  Return

}

searchClipBank() {

  assembleMenu(["Google", "StackOverFlow", "Twitter", "Youtube", "Reddit"])
  ToolTip, %THE_MENU%

  Input Key, L1
    ToolTip
    If Key=a
      querySearch("Google", "clipboard", "http://www.google.com/search?q=")
    Else If Key=s
      querySearch("Stack Overflow", "clipboard", "https://stackoverflow.com/search?q=")
    Else If Key=d
      querySearch("Twitter", "clipboard", "https://twitter.com/search?q=")
    Else If Key=z
      querySearch("YouTube", "clipboard", "https://www.youtube.com/search?q=")
    Else If Key=x
      querySearch("Reddit", "clipboard", "https://www.reddit.com/search?q=")
    Else If Key=c
      ; querySearch("CommRequests", "clipboard", "http://it32:8081/api/DCS/REQUESTS/")
  Return

}

s_Search:
  searchInputBank()
Return

l_Search:
  searchInputBank()
Return

d_Search:
  Send, ^c
  searchClipBank()
Return