#define MAX_MENU_OPTIONS 6

/* Started a single Char for menu option but that has no \n character so padded_label functionality broke    */

struct YD_MENU_ITEMS {
    char menu_option[2];
    char description[25];
};

void yd_menu(void){

    const static struct YD_MENU_ITEMS menu_options[MAX_MENU_OPTIONS] =
            {{.menu_option = "a", .description = "aaa"},
            {.menu_option = "b", .description = "bbb"},
            {.menu_option = "c", .description = "ccc"},
            {.menu_option = "d", .description = "ddd"},
            {.menu_option = "e", .description = "eee"},
            {.menu_option = "f", .description = "fff"}};


    for (int i = 0; i < MAX_MENU_OPTIONS; i++ ){
        printf("%s\t\t%s\n", menu_options[i].menu_option, menu_options[i].description);
    }

