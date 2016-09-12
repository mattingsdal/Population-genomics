
def bottle_split_bottleExpansion((B1,P1,nuW,nuEF,nuEB,TE), (n1,n2), pts):
    """
    Model with bottleneck, split, followed by second bottleneck and exp recovery in Eastern pop
    
    nu, or ancestral population size defaults to 1.
    
    B1= Time of the ancestral population bottleneck.
    P1= The ancestral population size after bottleneck.
    nuW: The size of the western population after split
    nuEF: The final size for the eastern population
    nuEB: The size of the eastern population after the bottleneck
    TE: The time of the eastern-western split

    n1,n2: Size of fs to generate.
    pts: Number of points to use in grid for evaluation.
    """ 
    #Define grid to use
    xx = yy = dadi.Numerics.default_grid(pts)
    
    #phi for equilibrium ancestral population
    phi = dadi.PhiManip.phi_1D(xx)
    
    # Now do the population bottleneck event.
    phi = dadi.Integration.one_pop(phi, xx, B1, P1)

    # grow the ancient population


    #The ancestral population splits into the West and East, and the East undergoes a second bottleneck followed by an exponential population size change.
    phi = dadi.PhiManip.phi_1D_to_2D(xx, phi)
    
    #Function for the Eastern population describing an second bottleneck followed by exponential population growth until present
    nuE_func = lambda t: nuEB*numpy.exp(numpy.log(nuEF/nuEB) * t/TE)

    # function for growth in west
    nuW_func = lambda t: numpy.exp(numpy.log(nuW) * t/TE)

    # integrate the two populations
    phi = dadi.Integration.two_pops(phi,xx,TE, nu1=nuW_func, nu2=nuE_func)
    
    #Return frequency spectrum
    fs = dadi.Spectrum.from_phi(phi, (n1,n2), (xx,yy))
    return fs



def split_bottleExpansion((nuW,nuEF,nuEB,TE), (n1,n2), pts):
    """
    Model with split, followed by second bottleneck and exp recovery in Eastern pop
    
    nu, or ancestral population size defaults to 1.
    

    nuW: The size of the western population after split
    nuEF: The final size for the eastern population
    nuEB: The size of the eastern population after the bottleneck
    TE: The time of the eastern-western split

    n1,n2: Size of fs to generate.
    pts: Number of points to use in grid for evaluation.
    """ 
    #Define grid to use
    xx = yy = dadi.Numerics.default_grid(pts)
    
    #phi for equilibrium ancestral population
    phi = dadi.PhiManip.phi_1D(xx)
    
    
    #The ancestral population splits into the West and East, and the East undergoes a second bottleneck followed by an exponential population size change.
    phi = dadi.PhiManip.phi_1D_to_2D(xx, phi)
    
    #Function for the Eastern population describing an second bottleneck followed by exponential population growth until present
    nuE_func = lambda t: nuEB*numpy.exp(numpy.log(nuEF/nuEB) * t/TE)

    # function for growth in west
    nuW_func = lambda t: numpy.exp(numpy.log(nuW) * t/TE)

    # integrate the two populations
    phi = dadi.Integration.two_pops(phi,xx,TE, nu1=nuW_func, nu2=nuE_func)
    
    #Return frequency spectrum
    fs = dadi.Spectrum.from_phi(phi, (n1,n2), (xx,yy))
    return fs



def bottlegrow_split_bottleExpansion((nu,T,nuW,nuEF,nuEB,TE), (n1,n2), pts):
    """
    Model with bottlegrowth, split, followed by second bottleneck and exp recovery in Eastern pop
    
    nu, or ancestral population size defaults to 1.
    
    nu= Ratio of contemporary to ancient population size
    T = Time in the past at which growth began
    nuW: The size of the western population after split
    nuEF: The final size for the eastern population
    nuEB: The size of the eastern population after the bottleneck
    TE: The time of the eastern-western split


    n1,n2: Size of fs to generate.
    pts: Number of points to use in grid for evaluation.
    """ 
    #Define grid to use
    xx = yy = dadi.Numerics.default_grid(pts)
    
    #phi for equilibrium ancestral population
    phi = dadi.PhiManip.phi_1D(xx)
    
    # bottlegrowth in ancient population
    nu_func = lambda t: numpy.exp(numpy.log(nu) * t/T)

    phi = Integration.one_pop(phi, xx, T, nu_func)


    #The ancestral population splits into the West and East, and the East undergoes a second bottleneck followed by an exponential population size change.
    phi = dadi.PhiManip.phi_1D_to_2D(xx, phi)
    
    #Function for the Eastern population describing an second bottleneck followed by exponential population growth until present
    nuE_func = lambda t: nuEB*numpy.exp(numpy.log(nuEF/nuEB) * t/TE)

    # function for growth in west
    nuW_func = lambda t: numpy.exp(numpy.log(nuW) * t/TE)

    # integrate the two populations
    phi = dadi.Integration.two_pops(phi,xx,TE, nu1=nuW_func, nu2=nuE_func)
    
    #Return frequency spectrum
    fs = dadi.Spectrum.from_phi(phi, (n1,n2), (xx,yy))
    return fs





    def bottlegrow_split_bottleExpansion_mig((nu,T,nuW,nuEF,nuEB,TE,m12,m21), (n1,n2), pts):
    """
    Model with bottlegrowth, split, followed by second bottleneck and exp recovery in Eastern pop
    
    nu, or ancestral population size defaults to 1.
    
    nu= Ratio of contemporary to ancient population size
    T = Time in the past at which growth began
    nuW: The size of the western population after split
    nuEF: The final size for the eastern population
    nuEB: The size of the eastern population after the bottleneck
    TE: The time of the eastern-western split
    m12: Migration from pop 2 to pop 1 (2*Na*m12)
    m21: Migration from pop 1 to pop 2

    n1,n2: Size of fs to generate.
    pts: Number of points to use in grid for evaluation.
    """ 
    #Define grid to use
    xx = yy = dadi.Numerics.default_grid(pts)
    
    #phi for equilibrium ancestral population
    phi = dadi.PhiManip.phi_1D(xx)
    
    # bottlegrowth in ancient population
    nu_func = lambda t: numpy.exp(numpy.log(nu) * t/T)

    phi = Integration.one_pop(phi, xx, T, nu_func)


    #The ancestral population splits into the West and East, and the East undergoes a second bottleneck followed by an exponential population size change.
    phi = dadi.PhiManip.phi_1D_to_2D(xx, phi)
    
    #Function for the Eastern population describing an second bottleneck followed by exponential population growth until present
    nuE_func = lambda t: nuEB*numpy.exp(numpy.log(nuEF/nuEB) * t/TE)

    # function for growth in west
    nuW_func = lambda t: numpy.exp(numpy.log(nuW) * t/TE)

    # integrate the two populations
    phi = dadi.Integration.two_pops(phi,xx,TE, nu1=nuW_func, nu2=nuE_func,m12=m12, m21=m21)
    
    #Return frequency spectrum
    fs = dadi.Spectrum.from_phi(phi, (n1,n2), (xx,yy))
    return fs


