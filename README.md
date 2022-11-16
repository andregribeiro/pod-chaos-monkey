<a name="pod-chaos-monkey"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/andregribeiro/pod-chaos-monkey">
    <img src="images/bad-monkey.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">Pod Chaos Monkey</h3>

  <p align="center">
    An awesome challenge to play with chaos engineering on k8s clusters!
    <br />
    <a href="https://github.com/andregribeiro/pod-chaos-monkey"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/andregribeiro/pod-chaos-monkey">View Demo</a>
    ·
    <a href="https://github.com/andregribeiro/pod-chaos-monkey/issues">Report Bug</a>
    ·
    <a href="https://github.com/andregribeiro/pod-chaos-monkey/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#example">Roadmap</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project provides:
- a script ([chaos-monkey-script.sh](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/scripts/chaos-monkey-script.sh)) which will be added on a Dockerfile that will be responsible for killing pods.
- a Dockerfile to build an image to run inside a kubernetes cluster.
- a job manifest to deploy the image created as the "chaos owner" in a specific namespace (Ex:"workloads")
- a deployment manifest as the "chaos test target" in a specific namespace "workloads" to test the job

<p align="right">(<a href="pod-chaos-monkey">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

Here is where all the information to get this running and understand this challenge will be presented.

### Prerequisites

* Kubernetes cluster up and running.

Here is some options to get you started:
[Local kubernetes cluster]  https://docs.docker.com/get-docker/ (Enable Kubernetes feature)
[Local kubernetes cluster]  https://minikube.sigs.k8s.io/docs/start/
[Online kubernetes cluster] https://killercoda.com/kubernetes/scenario/a-playground

### Usage

1. Create a docker image
   ```sh
    docker build . -t chaos-monkey:0.0.1
   ```
2. Deploy the "chaos test target"
   ```sh
   kubectl apply -f k8s/target-deployment.yaml
   ```
3. Deploy the "chaos owner" and all dependencies
   ```sh
    kubectl apply -f k8s/chaos-monkey.yaml
   ```

<p align="right">(<a href="pod-chaos-monkey">back to top</a>)</p>


## Example

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.
1. Create a docker image
![alt text](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/images/example/docker-build.jpg?raw=true)

[Extra] Scan image to check vulnerabilities. I used the Snyk plugin that Docker Desktop provided.
![alt text](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/images/example/docker-scan.jpg?raw=true)

2. Deploy the "chaos test target".
This deployment manifest has a specific label chaosmonkeytarget: "yes" as a security strategy to know which pods are available to be a target for our "chaos-monkey".
![alt text](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/images/example/target-deployment.jpg?raw=true)

3. Deploy the "chaos owner" and all dependencies
In this manifest we have all dependencies to provide our chaos-monkey permitions to kill some pods:
- Create a namespace where our chaos-monkey will "live" -> chaosmonkey
- Create a ServiceAccount (monkey-kill) to chaosmonkey use with specfic permissions.
- Create a ClusterRole (modify-pods) to give permitions of get, list, delete and watch for only resources of type "pod".
- Create a RoleBinding (modify-pods-monkeykill-sa) to give permitions to the ServiceAccount monkey-kill be able to use the ClusterRole modify-pods in "workloads" namespace only.
- Create a job to run a chaosmonkey pod that will delete some pods with spefic arguments:
  - "NAMESPACE": Here we can specify a specific namespace.
  - "NR_POD_TO_KILL": Here we can choose how many pods we want to kill.
  - "TIME_INTERVAL" : Here we chan choose the time interval between each kill.

Chaosmonkey job
![alt text](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/images/example/chaosmonkey-job.jpg?raw=true)

Chaosmonkey in action with k8s events
![alt text](https://github.com/andregribeiro/pod-chaos-monkey/blob/main/images/example/chaosmonkey-events-in-action.jpg?raw=true)


<p align="right">(<a href="pod-chaos-monkey">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="pod-chaos-monkey">back to top</a>)</p>


<!-- CONTACT -->
## Contact

André Ribeiro - [@My Linkedin](https://www.linkedin.com/in/andr%C3%A9--ribeiro/)

Project Link: [https://github.com/andregribeiro/pod-chaos-monkey/](https://github.com/andregribeiro/pod-chaos-monkey/)

<p align="right">(<a href="pod-chaos-monkey">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/andregribeiro/pod-chaos-monkey.svg?style=for-the-badge
[contributors-url]: https://github.com/andregribeiro/pod-chaos-monkey/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/andregribeiro/pod-chaos-monkey.svg?style=for-the-badge
[forks-url]: https://github.com/andregribeiro/pod-chaos-monkey/network/members
[stars-shield]: https://img.shields.io/github/stars/andregribeiro/pod-chaos-monkey.svg?style=for-the-badge
[stars-url]: https://github.com/andregribeiro/pod-chaos-monkey/stargazers
[issues-shield]: https://img.shields.io/github/issues/andregribeiro/pod-chaos-monkey.svg?style=for-the-badge
[issues-url]: https://github.com/andregribeiro/pod-chaos-monkey/issues
[license-shield]: https://img.shields.io/github/license/andregribeiro/pod-chaos-monkey.svg?style=for-the-badge
[license-url]: https://github.com/andregribeiro/pod-chaos-monkey/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/andr%C3%A9--ribeiro/
[product-screenshot]: images/bad-monkey.png
