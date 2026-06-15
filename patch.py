import re

with open("src/main.npk", "r") as f:
    content = f.read()

# Add gtk4_load_css_file at top
content = content.replace('raw gtk4_init();', 'raw gtk4_init();\n    raw gtk4_load_css_file("src/gui/style.css");')

# Define button classes
operator_btns = ["sin", "cos", "tan", "log", "pow", "sqrt", "pi", "ln", "e", "lpar", "rpar", "angle_mode", "mc", "mr", "mplus", "mminus", "ms", "ac", "c", "div", "mul", "sub", "add"]
number_btns = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", "dot"]
equals_btn = ["eq"]

for btn in operator_btns:
    search_str = f'int32:btn_{btn}  = raw gtk4_add_button'
    if search_str not in content:
        # try without spaces
        search_str = f'int32:btn_{btn}= raw gtk4_add_button'
    if search_str not in content:
        search_str = f'int32:btn_{btn} = raw gtk4_add_button'
    
    replace_str = search_str
    # Need to match the full line to append after it. Let's use regex
    pattern = r'(int32:btn_' + btn + r'\s*=\s*raw gtk4_add_button\("[^"]+"\);)'
    content = re.sub(pattern, r'\1\n    raw gtk4_widget_add_css_class(btn_' + btn + r', "btn-operator");', content)

for btn in number_btns:
    pattern = r'(int32:btn_' + btn + r'\s*=\s*raw gtk4_add_button\("[^"]+"\);)'
    content = re.sub(pattern, r'\1\n    raw gtk4_widget_add_css_class(btn_' + btn + r', "btn-number");', content)

for btn in equals_btn:
    pattern = r'(int32:btn_' + btn + r'\s*=\s*raw gtk4_add_button\("[^"]+"\);)'
    content = re.sub(pattern, r'\1\n    raw gtk4_widget_add_css_class(btn_' + btn + r', "btn-equals");', content)

with open("src/main.npk", "w") as f:
    f.write(content)

