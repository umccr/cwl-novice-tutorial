---
site: sandpaper::sandpaper_site
---

::::::::::::::::::: prereq

This tutorial guides you through the the fundamentals of designing and building an analysis workflow.
It assumes no previous knowledge or experience of workflows or Common Workflow Language (CWL), 
but does assume some experience with the Unix command line.

Before following this tutorial, you should be comfortable working in a Unix command line environment 
and familiar with fundamental commands (`cd`, `mv`, `mkdir`, etc), piping and redirection, and simple Bash scripting,
such as might be gained from following the [Software Carpentry][swc]
lesson, [The Unix Shell][swc_shell].

You might also have some experience with running tasks on a remote machine (by `ssh` connection) 
and in a cluster (high performance computing) environment.

CWL is based upon YAML. At any time, if you find yourself being confused by the YAML syntax, 
considering reviewing this guide on the [subset of YAML][yaml_for_cwl] used in CWL.

If you have previously written a workflow description, in CWL or another language, 
you may want to look instead at the [User Guide][cwl_user_guide].

::::::::::::::::::::

### Target Audience

This tutorial is aimed at researchers and research software engineers who would like to begin 
automating their analyses in workflows.

If you're unsure whether this tutorial is a good fit for you check the prerequisites listed above.

You may also find our [learner profiles][audience] helpful.

These are also a useful resource during the lesson design process.


[swc]: https://software-carpentry.org/
[swc_shell]: https://swcarpentry.github.io/shell-novice/
[yaml_for_cwl]: https://www.commonwl.org/user_guide/yaml/
[cwl_user_guide]: https://www.commonwl.org/user_guide/
