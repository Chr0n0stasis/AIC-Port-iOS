ROUNIN DEFINE_CURRENT_TSUNAGI_KEY _current_tsunagi_key

IFSTR $_current_tsunagi_key IS '' {
    SEEK_END
}

MSG $_current_tsunagi_key
ROUNIN WATCHED_TSUNAGI
