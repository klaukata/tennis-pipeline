use schema DB.RECENT;
copy into RAW_TABLE
    from @STAGE
    file_format = CSVFORMAT
    on_error = "continue";