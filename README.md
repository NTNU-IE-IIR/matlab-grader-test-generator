# Matlab Grader Test Generator

### What is Matlab Grader Test Generator?

Matlab Grader Test Generator is a tool to automatically write tests which can be used in the Grader portal.  All you need to provide are two templates; reference solutions and the learner template.  The end result is a .txt file with tests ready to be pasted into Matlab Grader.

### Features

- Compares two structures, selecting only the common elements
- Customize test output
- Option to manually exclude variables

### Installing

1. Clone the repository
2. Open Matlab (Confirmed to work with  2018a and 2018b)
3. Home → Open → navigate to ...\TestGenApp and select GenGui_app

The application will open in a new window.

### Getting started

Once the application has been opened, select a reference solution,
and the learner template. 
Select a path and enter a filename to save the output.
If default test format is desired, click the "generate test".
A .txt file will be generated at the chosen location.
A sample test might look like this

```matlab
disp('Reference Solution: ')
referenceVariables.SampleVariable
disp('Student Solution: ')
SampleVariable
assessVariableEqual('SampleVariable',referenceVariables.SampleVariable)
```

### All-in-one script

To autogenerate a sequence of tests for all variables contained inside a
single Matlab Grader assessment test, copy and paste the code inside the
script \Functions\all_in_one_.m to a Matlab Grader test window under
the Matlab Code option.


For more information head over to the [wiki](https://github.com/NTNU-IE-IIR/matlab-grader-test-generator/wiki)

[![View Matlab Grader Test Generator on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/70661-matlab-grader-test-generator) 
