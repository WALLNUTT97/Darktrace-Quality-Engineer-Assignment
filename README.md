
# 🚀 Robot Framework Test Runner with Docker

This setup allows you to run [Robot Framework](https://robotframework.org/) tests using a Docker container with minimal configuration.
Find an example test [here](./tests/work-sample-example.robot).
## 📂 Project Structure

```
├── tests/ # Place your Robot Framework test files here
└── reports/ # Test results and logs will be saved here
```
---

## 🧪 Running Tests

To run your Robot Framework tests using Docker, use the following command:

```bash
docker run \
  -v ./reports:/opt/robotframework/reports:Z \
  -v ./tests:/opt/robotframework/tests:Z \
  ppodgorsek/robot-framework:latest
  
```


* ./tests: Mounts your local test directory into the container.
* ./reports: Mounts the output directory to store test results.
* The :Z suffix ensures proper SELinux permissions (especially useful on Fedora, RHEL, or CentOS).

💡 Add more .robot test files to the [tests](./tests) directory to include them in the next run.

---
## 📊 Viewing Test Reports

After the test run, you can find the generated reports in the [reports](./reports) directory:

    📄 report.html – High-level test report
    📄 log.html – Detailed execution log
    📄 output.xml – Raw test output (useful for CI tools)

Open report.html in your browser to view the results.

