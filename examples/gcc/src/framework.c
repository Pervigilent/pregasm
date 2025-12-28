#include <stdio.h>
#include <string.h>

/*
 * getInput
 * ----------
 * Prints a prompt, reads a line from stdin, truncates to maxChars-1,
 * and guarantees null-termination.
 */
void getInput(const char *inputPrompt, char *result, int maxChars)
{
    char buffer[1024];

    /* Display prompt */
    if (inputPrompt && *inputPrompt)
    {
        printf("%s", inputPrompt);
        fflush(stdout);
    }

    /* Read input */
    if (fgets(buffer, sizeof(buffer), stdin) == NULL)
    {
        result[0] = '\0';
        return;
    }

    /* Remove trailing newline if present */
    buffer[strcspn(buffer, "\n")] = '\0';

    /* Truncate and copy */
    strncpy(result, buffer, maxChars - 1);
    result[maxChars - 1] = '\0';
}

/*
 * showOutput
 * -----------
 * Displays a labeled output block.
 */
void showOutput(const char *outputLabel, const char *outputString)
{
    if (outputLabel && *outputLabel)
        printf("%s\n", outputLabel);

    if (outputString)
        printf("%s\n", outputString);

    fflush(stdout);
}

