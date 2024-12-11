use schema DB.RECENT;
copy into RAW_TABLE
    from @"stage"
    file_format = CSVFORMAT
    on_error = "continue";