layout splits
launch --var window=main
launch --location=vsplit --bias=64
launch --location=hsplit --bias=36
launch --location=vsplit --bias=42
focus_matching_window var:window=main
