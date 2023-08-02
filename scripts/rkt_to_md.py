import os
import markdown
import re

def parse_racket_to_markdown(racket_str):
    lines = racket_str.split('\n')
    markdown_lines = []

    exercise_num_line = lines[0].strip("; ")
    exercise_num = re.search(r'\d+', exercise_num_line).group()

    markdown_lines.append(f"## Exercise {exercise_num}:\n")

    answer_start = lines.index(";;; --------------------------ANSWER:--------------------------------") + 1
    if ";;; --------------------------Testing:--------------------------------" in racket_str:
        test_start = lines.index(";;; --------------------------Testing:--------------------------------")
    else:
        test_start = len(lines)

    # Question
    for line in lines[1:answer_start - 1]:
        if line.strip().startswith(';'):
            markdown_lines.append(f"> {line.strip('; ')}")
        else:
            markdown_lines.append(f"```racket\n{line}\n```")
    markdown_lines.append("\n---\n")

    # Answer
    markdown_lines.append("### Answer:\n")
    for line in lines[answer_start:test_start]:
        if line.strip().startswith(';'):
            markdown_lines.append(f"> {line.strip('; ')}")
        else:
            markdown_lines.append(f"```racket\n{line}\n```")

    markdown_lines.append("\n<br>\n<br>\n<br>\n")

    return '\n'.join(markdown_lines)

def convert_files(directory, output_filename):
    markdown_strs = []
    for filename in os.listdir(directory):
        if filename.endswith('.rkt'):
            with open(os.path.join(directory, filename), 'r') as file:
                content = file.read()
                markdown_content = parse_racket_to_markdown(content)
                markdown_strs.append(markdown_content)

    markdown_document = '\n'.join(markdown_strs)
    with open(output_filename, 'w') as output_file:
        output_file.write(markdown_document)

# Replace 'your_directory' and 'output.md' with your actual directory and output file
convert_files('your_directory', 'output.md')
