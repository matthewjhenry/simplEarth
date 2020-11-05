### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ e9ad66b0-0d6b-11eb-26c0-27413c19dd32
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add("Plots")
	Pkg.add("PlutoUI")
	Pkg.add("LaTeXStrings")
	using LaTeXStrings
	using Plots
	using PlutoUI
end;

# ╔═╡ 05031b60-1df4-11eb-2b61-956e526b3d4a
md"## Lecture 2: Snowball Earth, the ice-albedo feedback, and multiple equilibria"

# ╔═╡ a05bd3ce-1e06-11eb-1af2-65886cab38ef
md"![](https://static01.nyt.com/images/2019/12/17/science/02TB-SNOWBALLEARTH1/02TB-SNOWBALLEARTH1-superJumbo-v2.jpg?quality=90&auto=webp)
[Source (New York Times)](https://static01.nyt.com/images/2019/12/17/science/02TB-SNOWBALLEARTH1/02TB-SNOWBALLEARTH1-superJumbo-v2.jpg?quality=90&auto=webp)
"

# ╔═╡ 4f5f3038-1e06-11eb-16a2-b11035701fb8
md"""
### Snowball Earth

Geological evidence shows that the Neoproterozoic Era (550 to 1000 million years ago) is marked by two global glaciation events, in which the surface was covered in ice and snow from the Equator to the poles (see review by [Pierrehumbert et al. 2011](https://www.annualreviews.org/doi/full/10.1146/annurev-earth-040809-152447)).

![](https://news.cnrs.fr/sites/default/files/styles/asset_image_full/public/assets/images/frise_earths_glaciations_72dpi.jpg?itok=MgKrHlIV)

In this lecture, we make a simple modification to our **zero-dimensional energy balance model** from Lecture 1 that will allow us to explore the dynamics behind these sudden glaciations.
"""

# ╔═╡ 9c118f9a-1df0-11eb-22dd-b14428994076
md"![](https://upload.wikimedia.org/wikipedia/commons/d/df/Ice_albedo_feedback.jpg)"

# ╔═╡ 38346e6a-0d98-11eb-280b-f79787a3c788
md"""
We can represent the ice-albedo feedback crudely in our energy balance model by allowing the albedo to depend on temperature:

$\alpha(T) = \begin{cases}
\alpha_{i} & \mbox{if }\;\; T \leq -10\text{°C} &\text{(completely frozen)}\\
\alpha_{i} + (\alpha_{0}-\alpha_{i})\frac{T + 10}{20} & \mbox{if }\;\; -10\text{°C} \leq T \leq 10\text{°C} &\text{(partially frozen)}\\
\alpha_{0} &\mbox{if }\;\; T \geq 10\text{°C} &\text{(no ice)}
\end{cases}$
"""

# ╔═╡ a8dcc0fc-1df8-11eb-21fd-1fdebe5dabfc
md"""
To implement this into our energy balance model from Lecture 1, all we have to do is overwrite the definition of the `timestep!` method to specify the temperature-dependent albedo at any given time:
"""

# ╔═╡ 13f42334-1e27-11eb-11a0-f51af4574a6b
md"""#### Multiple Equilibria (or the existence of "alternate Earths")
Human civilization flourished over the last several thousand years in part because Earth's global climate has been remarkably stable and forgiving. The preindustrial combination of natural greenhouse effect and incoming solar radiation yielded temperatures between the freezing and boiling points of water across most of the planet, allowing ecoystems based on liquid water to thrive.

The climate system, however, is rife with non-linear effects like the **ice-albedo effect**, which reveal just how fragile our habitable planet is and just how unique our stable pre-industrial climate was.

We know from Lecture 1 that in response to temperature fluctuations, *negative feedbacks* act to restore Earth's temperature back towards a single equilibrium state in which absorbed solar radiation is balanced by outgoing thermal radiation.
"""

# ╔═╡ 58e9b802-1e11-11eb-3479-0f7eb69b2c3a
md"
##### Turning up the Sun

Over the entire history of the Earth, the Sun is thought to have brightened by about 40%."

# ╔═╡ 846618ea-1f7e-11eb-15e8-6176acb9278b
html"""
<img src="https://rainbow.ldeo.columbia.edu/courses/s4021/ec98/fys.gif" alt="Plot showing increasing solar luminosity over time" height=300>
"""

# ╔═╡ 873befc2-1f7e-11eb-16af-fba7f1e52eeb
md"In the Neoproterozoic, the Sun was 93% as bright as it is today, such that the incoming solar radiation was $S =$ 1272 W/m², Earth's average temperature plunged to $T = -50$°C, and Earth's ice-covered surface had a high albedo (reflectivity) of $α_{i} = 0.6$.

##### How did Snowball Earth melt?
If we increase solar insolation to today's value of $S =$ 1368 W/m², can we warm the planet up to the pre-industrial temperature of $T=14$°C?
"

# ╔═╡ d423b466-1e2a-11eb-3bb0-77f8151cdeea
md"""*Extend upper-limit of insolation* $(@bind extend_S CheckBox(default=false))"""

# ╔═╡ e2e08386-1e22-11eb-1e02-059ce290e80f
if extend_S
	md"""
	*"Cold" branch* $(@bind show_cold CheckBox(default=false))    |   
	*"Warm" branch* $(@bind show_warm CheckBox(default=false))
	"""
else
	show_cold = true;
	nothing
end

# ╔═╡ 9474f8e4-1f80-11eb-3c9e-c54e662cc29c
md"""In this model, temperature variations are fairly smooth unless temperatures rise above -10°C or fall below 10°C, in which case the *ice-albedo positive feedback* kicks in and causes an **abrupt climate transition**. While this is just a simple hypothetical model, these kinds of abrupt climate transitions show up all the time in the paleoclimate record and in more realistic climate model simulations.

This simulation teaches us that we should not take the stability of our climate for granted and that pushing our present climate outside of its historical regime of stability could trigger catastrophic abrupt climate transitions.
"""

# ╔═╡ 6eca000c-1f81-11eb-068e-01d06c1beeb9
md"""
##### If it wasn't the Sun, how did the neoprotorezoic snowball melt?

In **Homework Problem Set XX**, you extend the above model to include the effect of CO2 and determine how much CO2 would need to be added to the snowball for it to melt.
"""

# ╔═╡ da4df78a-1e2c-11eb-1d4c-69b86e196526
md"""### Towards more realistic modelling

In this simple model, the preindustrial climate of $T=14$°C so warm that there is no ice anywhere on the planet. Indeed, the only 

So how did Earth's preindustrial climate, which was relatively stable for thousands of years, have substantial ice caps at the poles?

"""

# ╔═╡ 908b50a2-1f76-11eb-0eb5-11318be6896b
md"""
**The "Aquaplanet" (ocean-world) three-dimensional climate model**

An "Aquaplanet" is a three-dimensional global climate simulation of a hypothetical planet covered entirely by a single global Ocean. While this is of course very different from Earth, where 27% of the planet is covered in land, the "Aquaplanet" exhibits many of the same characteristics as Earth and is much more realistic than our zero-dimensional climate model above.

The video below shows that the Aquaplanet simulation exhibits a third equilibrium state, with a *mostly-liquid ocean but ice caps at the poles*, in addition to the two we found in our zero-dimensional model.

In **Homework Problem Set XX**, you will build a simple two-dimensional version of the aqua-planet and explore its stability.
"""

# ╔═╡ 507342e0-1f76-11eb-098a-0973155652e2
html"""
<iframe width="700" height="394" src="https://www.youtube.com/embed/lYm_IyBHMUs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ d2f4d882-1e2c-11eb-206b-b9ef5031a1bb
md"### Pluto Magic"

# ╔═╡ 61fc91ec-1df8-11eb-13c1-098c113b46ec
function restart_ebm!(ebm)
	ebm.T = [ebm.T[end]]
	ebm.t = [ebm.t[1]]
end

# ╔═╡ 9b39df12-1df9-11eb-2eb0-f138980be597
function plot_trajectory!(p, x, y; lw=8)
	n = size(x,1)
	plot!(x, y, color="black", alpha=collect(1/n:1/n:1.), linewidth=collect(0.:lw/n:lw), label=nothing)
	plot!((x[end], y[end]), color="black", marker=:c, markersize=lw/2*1.2, label=nothing, markerstrokecolor=nothing, markerstrokewidth=0.)
	return p
end;

# ╔═╡ 5cf4ccdc-0d7e-11eb-2683-fd9a72e763f2
md"""
### (Possible) Homework Exercises:
1. What happens if we add CO2 to the neoprotorezoic atmosphere? How much CO2 would we need to add (relevant to a modern background of 280 ppm) to un-freeze the snowball?
"""

# ╔═╡ d6a7e652-1f7d-11eb-2a5f-13ff13b9850c
md"""
### Appendix
"""

# ╔═╡ 1dc709e2-1de8-11eb-28da-fd7469ec50c2
function ingredients(path::String)
	# this is from the Julia source code (evalfile in base/loading.jl)
	# but with the modification that it returns the module instead of the last object
	name = Symbol(basename(path))
	m = Module(name)
	Core.eval(m,
        Expr(:toplevel,
             :(eval(x) = $(Expr(:core, :eval))($name, x)),
             :(include(x) = $(Expr(:top, :include))($name, x)),
             :(include(mapexpr::Function, x) = $(Expr(:top, :include))(mapexpr, $name, x)),
             :(include($path))))
	m
end

# ╔═╡ 96ed2f9a-1e29-11eb-09f4-23df52152b2f
Model = ingredients("1_energy_balance_model.jl"); # see ingredients function below

# ╔═╡ 016c1074-1df4-11eb-2da8-578e25d9456b
md"""### The ice-albedo feedback

In Lecture 1, we used a **constant** value $α =$ $(Model.hist.α) for Earth's planetary albedo, which is a reasonable thing to do for small climate variations relative to the present (such as the difference between the present-day and preindustrial climates). In the case of large variations, however, this approximation is not very reliable.

While oceans are dark and absorbant, $α_{ocean} \approx 0.05$, ice and snow are bright and reflective $\alpha_{ice,\,snow} \approx 0.5$ to $0.9$. Thus, if much of the ocean freezes, we expect Earth's albedo to rise dramatically, causing more sunlight to be reflected to space, which in turn causes even more cooling and more of the ocean to freeze, etc. This *positive* feedback effect is referred to as the **ice-albedo feedback** (see illustration below).
"""

# ╔═╡ 262fc3c6-1df2-11eb-332d-c1c9561b3710
function α(T; α0=Model.α, αi=0.5, ΔT=10.)
	if T < -ΔT
		return αi
	elseif -ΔT <= T < ΔT
		return αi + (α0-αi)*(T+ΔT)/(2ΔT)
	elseif T >= ΔT
		return α0
	end
end

# ╔═╡ f7761e40-1e23-11eb-2741-cfebfaf434ec
begin
	T_example = -20.:1.:20.
	plot(T_example, α.(T_example), lw=3., label="α(T)")
	plot!(ylabel="albedo α (planetary reflectivity)", xlabel="Temperature [°C]")
end

# ╔═╡ 872c8f2a-1df1-11eb-3cfc-3dd568926442
function Model.timestep!(ebm)
	ebm.α = α(ebm.T[end]) # Added this line
	append!(ebm.T, ebm.T[end] + ebm.Δt*Model.tendency(ebm));
	append!(ebm.t, ebm.t[end] + ebm.Δt);
end

# ╔═╡ 94852946-1e25-11eb-3425-210be17c23cd
begin	
	p_equil = plot(xlabel="year", ylabel="temperature [°C]", legend=:bottomright, xlims=(0,205), ylims=(-60, 30.))
	
	plot!([0, 200], [-60, -60], fillrange=[-10., -10.], fillalpha=0.3, c=:lightblue, label=nothing)
	annotate!(120, -20, text("completely frozen", 10, :darkblue))
	
	plot!([0, 200], [10, 10], fillrange=[30., 30.], fillalpha=0.09, c=:red, lw=0., label=nothing)
	annotate!(120, 25, text("no ice", 10, :darkred))
	for T0_sample in (-60.:5.:30.)
		ebm = Model.EBM(T0_sample, 0., 1., Model.CO2_const)
		Model.run!(ebm, 200)
		
		plot!(p_equil, ebm.t, ebm.T, label=nothing, )
	end
	
	T_meta = 7.5472
	for δT in 1.e-2*[-2, -1., 0., 1., 2.]
		ebm_meta = Model.EBM(T_meta+δT, 0., 1., Model.CO2_const)
		Model.run!(ebm_meta, 200)

		plot!(p_equil, ebm_meta.t, ebm_meta.T, label=nothing, linestyle=:dash)
	end
	
	plot!(p_equil, [200], [Model.T0], marker=:., label="Our pre-industrial climate (warm branch)", color=:orange, markersize=8)
	plot!(p_equil, [200], [-38.3], marker=:., label="Alternate universe pre-industrial climate (cold branch)", color=:aqua, markersize=8)
	plot!(p_equil, [200], [T_meta], marker=:d, label="Impossible alternate climate (metastable branch)", color=:pink, markersize=8, markerstrokecolor=:white, alpha=1., markerstrokestyle=:dash)
	p_equil
end

# ╔═╡ b5849000-0d68-11eb-3beb-c575e8d0ce8e
begin
	Smin = 1200
	Smax = 1800
	Smax_limited = 1650
	Svec = Smin:1.:Smax
	Svec = vcat(Svec, reverse(Svec))
	Tvec = zeros(size(Svec))

	local T_restart = -100.
	for (i, S) = enumerate(Svec)
		ebm = Model.EBM(T_restart, 0., 5., Model.CO2_const);
		ebm.S = S
		Model.run!(ebm, 500.)
		T_restart = ebm.T[end]
		Tvec[i] = deepcopy(T_restart)
	end
end;

# ╔═╡ 364e1d2a-1f78-11eb-177b-9dcec4b6da38
md"""
For insolations $S$ between $(Smin) W/m² and $(Smax_limited) W/m², temperatures always remain below -10°C and the planet remains completely frozen. What if we extend the upper limit on insolation so that the Sun becomes bright enough to start melting ice?
"""

# ╔═╡ 90ae18dc-0db8-11eb-0d73-c3b7efaef9b0
begin
		Sneo = Model.S*0.93
		Tneo = -48.
end;

# ╔═╡ 5ca7ac14-1df9-11eb-13f3-e5c86333ef83
begin
	if extend_S
		solarSlider = @bind S Slider(Smin:2.:Smax, default=Sneo);
		md""" $(Smin) W/m² $(solarSlider) $(Smax) W/m²"""
	else
		solarSlider = @bind S Slider(Smin:2.:Smax_limited, default=Sneo);
		md""" $(Smin) W/m² $(solarSlider) $(Smax_limited) W/m²"""
	end
end

# ╔═╡ 0bbcdf5a-0dba-11eb-3e81-2b075d4f67ea
begin
	md"""
	*Move the slider below to change the brightness of the Sun (solar insolation):* S = $(S) [W/m²]
	"""
end

# ╔═╡ 7765f834-0db0-11eb-2c46-ef65f4a1fd1d
begin
	ebm = Model.EBM(Tneo, 0., 5., Model.CO2_const)
	ebm.S = Sneo
	
	ntraj = 10
	Ttraj = repeat([NaN], ntraj)
	Straj = repeat([NaN], ntraj)
end;

# ╔═╡ 0f222836-0d6c-11eb-2ee8-45545da73cfd
begin
	S
	warming_mask = (1:size(Svec)[1]) .< size(Svec)./2
	p = plot(xlims=(Smin, Smax_limited), ylims=(-55, 75))
	plot!([Model.S, Model.S], [-55, 75], color=:darkred, alpha=0.3, lw=5, label="Pre-industrial / present insolation")
	if extend_S
		plot!(p, xlims=(Smin, Smax))
		if show_cold
			plot!(Svec[warming_mask], Tvec[warming_mask], color=:blue,lw=3., alpha=0.5, label="cool branch")
		end
		if show_warm
			plot!(Svec[.!warming_mask], Tvec[.!warming_mask], color="red", lw=3., alpha=0.5, label="warm branch")
		end
	end
	plot!(legend=:topleft)
	plot!(xlabel="solar insolation S [W/m²]", ylabel="Global temperature T [°C]")
	plot!([Model.S], [Model.T0], marker=:., label="Our preindustrial climate", color=:orange, markersize=8)
	plot!([Model.S], [-38.3], marker=:., label="Alternate preindustrial climate", color=:aqua, markersize=8)
	plot!([Sneo], [Tneo], marker=:., label="neoproterozoic (700 Mya)", color=:lightblue, markersize=8)
	plot_trajectory!(p, reverse(Straj), reverse(Ttraj), lw=9)
	
	plot!([Smin, Smax], [-60, -60], fillrange=[-10., -10.], fillalpha=0.3, c=:lightblue, label=nothing)
	annotate!(Smin+20, -15, text("completely frozen", 10, :darkblue, :left))
	
	plot!([Smin, Smax], [10, 10], fillrange=[80., 80.], fillalpha=0.09, c=:red, lw=0., label=nothing)
	annotate!(Smin+20, 15, text("no ice", 10, :darkred, :left))
end

# ╔═╡ 477732c4-0daf-11eb-1422-cf0f55cd835b
begin
	S
	restart_ebm!(ebm)
	ebm.S = S
	Model.run!(ebm, 500)

	insert!(Straj, 1, copy(S))
	pop!(Straj)

	insert!(Ttraj, 1, copy(ebm.T[end]))
	pop!(Ttraj)
end;

# ╔═╡ Cell order:
# ╟─05031b60-1df4-11eb-2b61-956e526b3d4a
# ╟─a05bd3ce-1e06-11eb-1af2-65886cab38ef
# ╟─4f5f3038-1e06-11eb-16a2-b11035701fb8
# ╟─016c1074-1df4-11eb-2da8-578e25d9456b
# ╟─9c118f9a-1df0-11eb-22dd-b14428994076
# ╟─38346e6a-0d98-11eb-280b-f79787a3c788
# ╟─262fc3c6-1df2-11eb-332d-c1c9561b3710
# ╟─f7761e40-1e23-11eb-2741-cfebfaf434ec
# ╟─a8dcc0fc-1df8-11eb-21fd-1fdebe5dabfc
# ╠═96ed2f9a-1e29-11eb-09f4-23df52152b2f
# ╠═872c8f2a-1df1-11eb-3cfc-3dd568926442
# ╟─13f42334-1e27-11eb-11a0-f51af4574a6b
# ╟─94852946-1e25-11eb-3425-210be17c23cd
# ╟─58e9b802-1e11-11eb-3479-0f7eb69b2c3a
# ╟─846618ea-1f7e-11eb-15e8-6176acb9278b
# ╟─873befc2-1f7e-11eb-16af-fba7f1e52eeb
# ╟─0bbcdf5a-0dba-11eb-3e81-2b075d4f67ea
# ╟─5ca7ac14-1df9-11eb-13f3-e5c86333ef83
# ╟─0f222836-0d6c-11eb-2ee8-45545da73cfd
# ╟─364e1d2a-1f78-11eb-177b-9dcec4b6da38
# ╟─d423b466-1e2a-11eb-3bb0-77f8151cdeea
# ╟─e2e08386-1e22-11eb-1e02-059ce290e80f
# ╟─9474f8e4-1f80-11eb-3c9e-c54e662cc29c
# ╟─6eca000c-1f81-11eb-068e-01d06c1beeb9
# ╟─da4df78a-1e2c-11eb-1d4c-69b86e196526
# ╟─908b50a2-1f76-11eb-0eb5-11318be6896b
# ╟─507342e0-1f76-11eb-098a-0973155652e2
# ╠═d2f4d882-1e2c-11eb-206b-b9ef5031a1bb
# ╠═61fc91ec-1df8-11eb-13c1-098c113b46ec
# ╠═7765f834-0db0-11eb-2c46-ef65f4a1fd1d
# ╠═477732c4-0daf-11eb-1422-cf0f55cd835b
# ╠═b5849000-0d68-11eb-3beb-c575e8d0ce8e
# ╠═9b39df12-1df9-11eb-2eb0-f138980be597
# ╠═90ae18dc-0db8-11eb-0d73-c3b7efaef9b0
# ╟─5cf4ccdc-0d7e-11eb-2683-fd9a72e763f2
# ╟─d6a7e652-1f7d-11eb-2a5f-13ff13b9850c
# ╟─1dc709e2-1de8-11eb-28da-fd7469ec50c2
# ╠═e9ad66b0-0d6b-11eb-26c0-27413c19dd32
