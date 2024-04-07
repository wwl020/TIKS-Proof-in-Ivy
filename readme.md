## File Structure
```
.
├── build-container.sh (Script to build a docker with Ivy installed)
├── Dockerfile (The Docker container specification)
├── readme.md (This document)
└── tiks-proof (The TIKS proof code written in Ivy, see next section for details)
    ├── tiks.ivy
    ├── tiks.ivy.log
    ├── tiks_no_simp.ivy
    ├── tiks_no_simp.ivy.log
    ├── tiks_no_simp_2.ivy
    └── tiks_no_simp_2.ivy.log
```

## Proof Code
`tiks.ivy` contains the proof code that we described in the paper, which is a successful proof with two proper protocol simplifications (simplified state retrieval and reversed recover steps) reported in Sec.5 of the paper. The output log `tiks.ivy.log` shows the proof result.

To illustrate how these simplifications help the proof, we also developed two additional Ivy files `tiks_no_simp.ivy` and `tiks_no_simp_2.ivy`, showing the results without these simplifications:
- `tiks_no_simp.ivy` : It contains the proof code without the two simplifications. Compared to `tiks.ivy`, this file let TIKS nodes retrieve states using network messages and recover in a "reconstruction then write back" manner. This results in a spurious counterexample explained in Sec.5.1, which is also logged in `tiks_no_simp.ivy.log`. In the log we can observe that the RetrieveStorage responses represented by m_recover_resp may not capture the KV store of the responding node at the time when it receives the RetrieveStorage request and thus cause this counterexample. 
- `tiks_no_simp_2.ivy` : Based on `tiks_no_simp.ivy`, this file simplifies the state retrieval but keeps the recovery steps unchanged. Compared to `tiks.ivy`, this file let TIKS nodes perform recovery in a "reconstruction then write back" manner, which results in a spurious counterexample logged in `tiks_no_simp_2.ivy.log` (explained in Sec.5.2).

## Check the Proof using Ivy
1. Generate a Docker image (This command should run in current directory): `sudo ./build-container.sh`
2. Start a Docker container of the generated image: `sudo docker run -it ivy-docker/tiks`
3. Inside the container, use Ivy to check the proof: `ivy_check trace=true complete=fo tiks.ivy`