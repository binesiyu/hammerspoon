-- Spotlight-like Google search
chooser = hs.chooser.new(function(args)
    os.execute(string.format("open %s", args.subText))
end)
chooser:queryChangedCallback(function(query)
    query = query:gsub(" ", "+")
    chooser:choices({
        {
            ["text"] = string.format("Search Google for `%s`", query),
            ["subText"] = string.format("https://www.google.ca/#q=%s", query),
        },
        {
            ["text"] = string.format("Search Google Finance for `%s`", query),
            ["subText"] = string.format("https://www.google.ca/finance?q=%s", query),
        },
        {
            ["text"] = string.format("Open subreddit `%s`", query),
            ["subText"] = string.format("https://www.reddit.com/r/%s", query),
        },
    })
end)
chooser:bgDark(true)
chooser:rows(3)
lastFocus = nil
hs.hotkey.bind({"ctrl"}, "space", function()
    if chooser:isVisible() then
        chooser:hide()
        lastFocus:focus()
    else
        lastFocus = hs.window.focusedWindow()
        chooser:show()
    end
end)